class BooksController < ApplicationController
  before_action :require_login, only: %i[create]

  def index
    @books = Book.all.includes(:user)
  end

  def create
    @book = build_active_record #失敗した場合の処理を追加
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

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy!
    redirect_to books_path, success: '投稿を削除しました'
  end

  def search
    @book = build_active_model #失敗したときの処理を追加
    @book ||= SearchBooksForm.new(book_params)
  end

  private

  def get_json_by_params
    JSON.parse(Net::HTTP.get(URI.parse(
      "https://www.googleapis.com/books/v1/volumes?q=isbn:#{book_params['isbn']}"
    )))
  end

  def make_hash_of_googlebooksapi
    json = get_json_by_params
    {
      author: json["items"][0]["volumeInfo"]["authors"][0],
      description: json["items"][0]["volumeInfo"]["description"],
      image: "", #あとでcarrierwaveでの処理に変更する
      isbn: book_params['isbn'].to_i,
      googlebooksapi_id: json["items"][0]["id"],
      published_at: json["items"][0]["volumeInfo"]["publishedDate"],
      title: json["items"][0]["volumeInfo"]["title"],
    }
  end

  def build_active_record
    @book = current_user.books.build(make_hash_of_googlebooksapi)
  end

  def build_active_model
    @book = SearchBooksForm.new(make_hash_of_googlebooksapi)
  end

  def book_params
    params.fetch(:q, {}).permit(:isbn)
  end
end
