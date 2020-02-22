class BooksController < ApplicationController
  def new
    @url = "hogehoge"
  end

  def search_by_isbn
    @url = "https://api.openbd.jp/v1/get?isbn=" + params[:isbn]
  end
end
