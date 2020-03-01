class BooksController < ApplicationController
  before_action :require_login, only: %i[create destroy]

  def index
    @books = Book.all.includes(:user).page(params[:page]).per(15).order(created_at: :desc)
  end

  def create
    get_objects_from_keyword(book_create_params)
    @book = current_user.books.build(ここに情報入れる)
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
    json = get_json_from_keyword(search_books_params['keyword'])
    objs = json['items']
    objs.each do |obj|
      @books << Book.new(
        author: author(obj),
        description: obj['volumeInfo']['description'],
        remote_image_url: image_url(obj),
        googlebooksapi_id: obj['id'],
        published_at: obj['volumeInfo']['publishedDate'],
        title: obj['volumeInfo']['title'],
        buyLink: obj['saleInfo']['buyLink']
      )
    end
    @books = Kaminari.paginate_array(@books).page(params[:page]).per(5) #N+1問題を起こしうるので修正予定
  end

  private

  def get_json_from_keyword(keyword)
    JSON.parse(Net::HTTP.get(URI.parse(URI.escape(
                                         "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&country=JP&maxResults=20"
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

  def search_books_params
    params.fetch(:q, {}).permit(:keyword)
  end

  def book_create_params
    params.require(:book).permit(:googlebooksapi_id)
  end
end
