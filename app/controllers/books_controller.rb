class BooksController < ApplicationController
  before_action :require_login, only: %i[create]

  def create
    google_book = GoogleBook.new_from_id(create_book_params[:googlebooksapi_id])
    @book = google_book.build_book_by_user(current_user)
    if @book.save
      current_user.like(@book)
      redirect_to books_path, success: '本を登録しました'
    else
      flash.now[:danger] = '本の登録に失敗しました'
      render :search_books_path
    end
  end

  def new
    @google_book = GoogleBook.new_from_id(create_book_params[:googlebooksapi_id])
    @book = Book.find_by(googlebooksapi_id: @google_book.googlebooksapi_id)
  end

  def show
    @book = GoogleBook.new_from_id(params[:id])
    # @questions = @book.questions.includes(:user).order(created_at: :desc).page(params[:page]).per(8)
    render layout: 'book_detail'
  end

  def search
    @search_form = SearchBooksForm.new(search_books_params)
    books = GoogleBook.search(@search_form.keyword)
    @books = Kaminari.paginate_array(books).page(params[:page])
  end

  private

  def search_books_params
    params.fetch(:q, keyword: '').permit(:keyword)
  end

  def create_book_params
    params.permit(:googlebooksapi_id)
  end
end
