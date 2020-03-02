class BooksController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    hash = Book.hash_from_volume(volume_from_create_params)
    @book = current_user.books.build(hash)
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :new
    end
  end

  def new
    @book = Book.new_from_volume(volume_from_create_params)
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
    @search_form = SearchBooksForm.new(search_books_params)
    if params[:q].present?
      json = get_json_from_keyword(search_books_params[:keyword])
      items = json['items']
      @books = []
      items.each do |volume|
        hash = SearchBooksForm.hash_from_volume(volume)
        @books << SearchBooksForm.new(hash)
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

  def volume_from_create_params
    Book.get_json_from_id(create_book_params[:googlebooksapi_id])
  end

  private

  def search_books_params
    params.fetch(:q, keyword: '').permit(:keyword)
  end

  def create_book_params
    params.permit(:googlebooksapi_id)
  end
end
