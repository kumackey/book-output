class BooksController < ApplicationController
  include GoogleBooksApi
  before_action :require_login, only: %i[create destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    book = GoogleBook.new_from_id(create_book_params[:googlebooksapi_id])
    @book = current_user.books.build(
      author: book.author,
      description: book.description,
      googlebooksapi_id: book.googlebooksapi_id,
      published_at: book.published_at,
      title: book.title,
      buy_link: book.buy_link
    ) # DBの情報を持ちすぎてるので、本当ならモデルに移行したい
    @book.remote_image_url = book.image if book.image.present?
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
  end

  def destroy
    @book = current_user.books.find(params[:id])
    @book.destroy!
    redirect_to books_path, success: '投稿を削除しました'
  end

  def search
    @search_form = SearchBooksForm.new(search_books_params)
    if params[:q].present?
      books = GoogleBook.search(search_books_params[:keyword])
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
