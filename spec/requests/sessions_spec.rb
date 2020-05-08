require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'ログイン画面の表示は、' do
    context 'ログインしていない場合は' do
      it '成功すること' do
        get '/login'
        expect(response).to have_http_status(200)
      end
    end
    context 'ログインしている場合は' do
      it 'Homeにリダイレクトされること' do
        login
        get '/login'
        expect(response).to redirect_to home_path
      end
    end
  end

  it 'ログインに成功すること' do
    user = create(:user, password: 'password', password_confirmation: 'password')
    post '/login', params: { login_form: {
      email: user.email,
      password: 'password'
    } }
    expect(response).to redirect_to home_path
  end

  it 'ゲストログインに成功すること' do
    create(:user, email: 'guest@guest.jp') unless User.find_by(email: 'guest@guest.jp')
    post '/guest_login'
    expect(response).to redirect_to home_path
    follow_redirect!
    expect(response.body).to include('ゲストユーザーとして')
  end

  it 'ログアウトに成功すること' do
    login
    delete '/logout'
    expect(response).to redirect_to login_path
    follow_redirect!
    expect(response.body).to include('ログアウトしました')
  end
end
