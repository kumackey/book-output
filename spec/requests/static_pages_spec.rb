require 'rails_helper'

RSpec.describe 'Static_pages', type: :request do
  it 'ログイン時にTop画面に行こうとするとHome画面にリダイレクトされること' do
    login
    get '/'
    expect(response).to redirect_to home_path
  end

  it '非ログイン時にTop画面の取得に成功すること' do
    get '/'
    expect(response).to have_http_status(200)
  end

  it 'ログイン時にHome画面の取得に成功すること' do
    login
    get '/home'
    expect(response).to have_http_status(200)
    expect(response.body).to include('Home')
  end

  it '非ログイン時にHome画面に行こうとするとログイン画面にリダイレクトされること' do
    get '/home'
    expect(response).to redirect_to login_path
  end

  it 'contact me画面の取得に成功すること' do
    get '/contact'
    expect(response).to have_http_status(200)
    expect(response.body).to include('kumackey')
  end
end
