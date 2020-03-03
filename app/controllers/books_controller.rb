class BooksController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    @book = current_user.books.build(hash_from_create_params)
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :new
    end
  end

  def new
    @book = Book.new(hash_from_create_params)
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
      url = SearchBooksForm.url_of_searching_from_keyword(search_books_params[:keyword])
      json = Book.get_json_from_url(url)
      volumes = json['items']
      @books = []
      volumes.each do |volume|
        hash = SearchBooksForm.hash_from_volume(volume)
        @books << SearchBooksForm.new(hash)
      end
      @books = Kaminari.paginate_array(@books)
    else
      @books = Book.order(created_at: :desc).includes(:user)
    end
    @books = @books.page(params[:page]).per(5)
  end

  def hash_from_create_params
    volume = Book.get_json_from_url(Book.url_of_creating_from_id(create_book_params[:googlebooksapi_id]))
    Book.hash_from_volume(volume)
  end

  private

  def search_books_params
    params.fetch(:q, keyword: '').permit(:keyword)
  end

  def create_book_params
    params.permit(:googlebooksapi_id)
  end
end
