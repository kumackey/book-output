class BooksController < ApplicationController
  def create
    json = get_json_by_params
    @book = build_book_by(json) if json[0]
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :new
    end
  end

  def new
    @book ||= SearchBooksForm.new
  end

  def search_by_isbn
    hash = get_json_by_params
    @book = build_book_model_from(hash) if hash[0]
    @book ||= Book.new
    render :new
  end

  private

  def get_json_by_params
    JSON.parse(Net::HTTP.get(URI.parse(
      "https://api.openbd.jp/v1/get?isbn=#{book_params["isbn"]}"
    )))
  end

  def build_book_record_by(hash)
    @book = current_user.books.build(
      author: hash[0]["summary"]["author"],
      detail: hash[0]["onix"]["DescriptiveDetail"]["TitleDetail"]["TitleElement"]["Subtitle"]["content"],
      image: "", #あとでcarrierwaveでの処理に変更する
      isbn: hash[0]["summary"]["isbn"].to_i,
      published_at: hash[0]["summary"]["pubdate"], # 例: "20190101"
      title: hash[0]["summary"]["title"],
    )
  end

  def build_book_model_from(hash)
    @book = SearchBooksForm.new(
      author: hash[0]["summary"]["author"],
      detail: hash[0]["onix"]["DescriptiveDetail"]["TitleDetail"]["TitleElement"]["Subtitle"]["content"],
      image: "", #あとでcarrierwaveでの処理に変更する
      isbn: hash[0]["summary"]["isbn"].to_i,
      published_at: hash[0]["summary"]["pubdate"], # 例: "20190101"
      title: hash[0]["summary"]["title"],
    )
  end

  def book_params
    params.require(:book).permit(:isbn)
  end
end
