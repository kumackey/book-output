class BooksController < ApplicationController
  before_action :require_login, only: %i[create]

  def index
    @books = Book.all.includes(:user)
  end

  def create
    @book = current_user.books.build(make_hash_of_googlebooksapi)
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :new
    end
  end

  def new
    @book = Book.new
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
    @book = SearchBooksForm.new(make_hash_of_googlebooksapi)
  end

  private

  def get_json_from_isbn(isbn)
    JSON.parse(Net::HTTP.get(URI.parse(
                               "https://www.googleapis.com/books/v1/volumes?q=isbn:#{isbn}"
                             )))
  end

  def make_hash_of_googlebooksapi
    json = get_json_from_isbn(book_params['isbn'])
    image_url = json['items'][0]['volumeInfo']['imageLinks']['smallThumbnail']
    {
      author: json['items'][0]['volumeInfo']['authors'][0],
      description: json['items'][0]['volumeInfo']['description'],
      isbn: book_params['isbn'].to_i,
      remote_image_url: image_url,
      googlebooksapi_id: json['items'][0]['id'],
      published_at: json['items'][0]['volumeInfo']['publishedDate'],
      title: json['items'][0]['volumeInfo']['title'],
      buyLink: json['items'][0]['saleInfo']['buyLink']
    }
  end

  def book_params
    params.fetch(:q, {}).permit(:isbn)
  end
end
