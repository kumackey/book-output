class BooksController < ApplicationController
  def index
    @books = Book.all.page(params[:page]).per(10).order(created_at: :desc)
  end

  def create
    google_book = GoogleBook.new_from_id(create_book_params[:googlebooksapi_id])
    if (@book = google_book.find_book_or_save)
      redirect_to @book
    else
      redirect_to search_books_path, danger: 'ページの表示に失敗しました'
    end
  end

  def show
    @book = Book.find(params[:id])
    @questions = @book.questions.includes(:user).order(created_at: :desc).page(params[:page]).per(8)
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
