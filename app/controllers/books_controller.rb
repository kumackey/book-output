class BooksController < ApplicationController
  before_action :require_login, only: %i[create]

  def index
    @books = Book.all.includes(:user)
  end

  def create
    json = get_json_by_params
    @book = build_active_record_from_json(json) if json[0]
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :new
    end
  end

  def new
    @book = SearchBooksForm.new(book_params)
  end

  def search
    json = get_json_by_params
    @book = build_active_model_from_json(json) if json[0]
    @book ||= SearchBooksForm.new(book_params)
  end

  private

  def get_json_by_params
    JSON.parse(Net::HTTP.get(URI.parse(
      "https://api.openbd.jp/v1/get?isbn=#{book_params["isbn"]}"
    )))
  end

  def convert_json_into_hash(json)
    {
      author: json[0]["summary"]["author"],
      detail: json[0]["onix"]["DescriptiveDetail"]["TitleDetail"]["TitleElement"]["Subtitle"]["content"],
      image: "", #あとでcarrierwaveでの処理に変更する
      isbn: json[0]["summary"]["isbn"].to_i,
      published_at: json[0]["summary"]["pubdate"], # 例: "20190101"
      title: json[0]["summary"]["title"],
    }
  end

  def build_active_record_from_json(json)
    @book = current_user.books.build(convert_json_into_hash(json))
  end

  def build_active_model_from_json(json)
    @book = SearchBooksForm.new(convert_json_into_hash(json))
  end

  def book_params
    params.fetch(:q, {}).permit(:isbn)
  end
end
