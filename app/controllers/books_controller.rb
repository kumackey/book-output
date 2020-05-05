class BooksController < ApplicationController
  def show
    @book = GoogleBook.new_from_id(params[:id])
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
