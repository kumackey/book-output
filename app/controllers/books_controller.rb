class BooksController < ApplicationController
  include GoogleBooksApi # app/lib
  before_action :require_login, only: %i[create destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    hash = Book.hash_from_id(create_book_params[:googlebooksapi_id])
    @book = current_user.books.build(hash)
    if @book.save
      redirect_back_or_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :search
    end
  end

  def new
    @book = GoogleBook.new_from_id(create_book_params[:googlebooksapi_id])
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
      books = SearchBooksForm.search(search_books_params[:keyword])
      @books = Kaminari.paginate_array(books).page(params[:page]).per(5)
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
