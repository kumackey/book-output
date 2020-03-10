class BooksController < ApplicationController
  before_action :require_login, only: %i[create new]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    google_book = GoogleBook.new_from_id(create_book_params[:googlebooksapi_id])
    @book = current_user.books.build
    @book = @book.substitute_for_googlebook(google_book)
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :search_books_path
    end
  end

  def new
    @book = GoogleBook.new_from_id(create_book_params[:googlebooksapi_id])
  end

  def show
    @book = Book.find(params[:id])
    @outputs = @book.outputs.includes(:user).order(created_at: :desc).page(params[:page]).per(8)
  end

  def search
    @search_form = SearchBooksForm.new(search_books_params)
    if params[:q].present?
      books = GoogleBook.search(search_books_params[:keyword])
      @books = Kaminari.paginate_array(books).page(params[:page]).per(12)
    else
      @books = Kaminari.paginate_array([]).page(params[:page])
    end
  end

  private

  def search_books_params
    params.fetch(:q, keyword: '').permit(:keyword)
  end

  def create_book_params
    params.permit(:googlebooksapi_id)
  end
end
