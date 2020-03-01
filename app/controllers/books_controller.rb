class BooksController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    @book = current_user.books.build(hash_when_create_book)
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :new
    end
  end

  def new
    @book = Book.new(hash_when_create_book)
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
    @search_form = SearchBooksForm.new
    if params[:q].present?
      json = get_json_from_keyword(search_books_params[:keyword])
      objs = json['items']
      @books = []
      objs.each do |obj|
        @books << SearchBooksForm.new(hash_when_search_book(obj))
      end
      @books = Kaminari.paginate_array(@books)
    else
      @books = Book.order(created_at: :desc).includes(:user)
    end
    @books = @books.page(params[:page]).per(5)
  end

  def get_json_from_keyword(keyword)
    JSON.parse(Net::HTTP.get(URI.parse(URI.escape(
                                         "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP&maxResults=20"
                                       ))))
  end

  def get_json_from_id(googlebooksapi_id)
    JSON.parse(Net::HTTP.get(URI.parse(URI.escape(
                                         "https://www.googleapis.com/books/v1/volumes?q=id:#{googlebooksapi_id}&country=JP&maxResults=1"
                                       ))))
  end

  def image_url(obj)
    if obj['volumeInfo']['imageLinks'] # imageLinksが無く、エラーを起こすことがあるため
      obj['volumeInfo']['imageLinks']['smallThumbnail']
    else
      ''
    end
  end

  def author(obj)
    if !obj['volumeInfo']
      obj['volumeInfo']['authors'][0]
    else
      obj['volumeInfo']['publisher'] || "-"
    end
  end

  def hash_when_create_book
    json = get_json_from_id(create_book_params[:googlebooksapi_id])
    obj = json['items'][0]
    {
      author: author(obj),
      description: obj['volumeInfo']['description'],
      remote_image_url: image_url(obj),
      googlebooksapi_id: obj['id'],
      published_at: obj['volumeInfo']['publishedDate'],
      title: obj['volumeInfo']['title'],
      buyLink: obj['saleInfo']['buyLink']
    }
  end

  def hash_when_search_book(obj)
    {
      author: author(obj),
      remote_image_url: image_url(obj),
      googlebooksapi_id: obj['id'],
      title: obj['volumeInfo']['title'],
      buyLink: obj['saleInfo']['buyLink']
    }
  end

  private

  def search_books_params
    params.fetch(:q, keyword: '').permit(:keyword)
  end

  def create_book_params
    params.permit(:googlebooksapi_id)
  end
end
