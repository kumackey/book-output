class BooksController < ApplicationController
  before_action :require_login, only: %i[create destroy]

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
    @book = SearchBooksForm.new
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
    jsons = get_jsons_from_keyword(book_params['keyword'])
    @books = []
    jsons.each do |json|
      image_url = if json['volumeInfo']['imageLinks']
        json['volumeInfo']['imageLinks']['smallThumbnail']
      else
        ""
      end
      author = json['volumeInfo']['publisher'] || json['volumeInfo']['authors'][0]
      @books << Book.new(
        author: author,
        description: json['volumeInfo']['description'],
        # isbn: book_isbn_params['isbn'].to_i,
        remote_image_url: image_url,
        googlebooksapi_id: json['id'],
        published_at: json['volumeInfo']['publishedDate'],
        title: json['volumeInfo']['title'],
        buyLink: json['saleInfo']['buyLink']
      )
    end
  end

  private

  def get_jsons_from_keyword(keyword)
    objs = JSON.parse(Net::HTTP.get(URI.parse(URI.encode(
        "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP"
    ))))
    objs["items"]
  end

  def book_params
    params.fetch(:q, {}).permit(:keyword)
  end
end
