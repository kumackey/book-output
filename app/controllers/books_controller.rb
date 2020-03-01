class BooksController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
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
    @books = []
    json = get_jsons_from_keyword(book_params['keyword'])
    objs = json['items']
    objs.each do |obj|
      @books << Book.new(
        author: author(obj),
        description: obj['volumeInfo']['description'],
        # isbn: book_isbn_params['isbn'].to_i,
        remote_image_url: image_url(obj),
        googlebooksapi_id: obj['id'],
        published_at: obj['volumeInfo']['publishedDate'],
        title: obj['volumeInfo']['title'],
        buyLink: obj['saleInfo']['buyLink']
      )
    end
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(5)
  end

  private

  def get_jsons_from_keyword(keyword)
    JSON.parse(Net::HTTP.get(URI.parse(URI.escape(
                                         "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP"
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
    obj['volumeInfo']['publisher'] || obj['volumeInfo']['authors'][0]
    # publisherとauthorsの2種がある
  end

  def book_params
    params.fetch(:q, {}).permit(:keyword)
  end
end
