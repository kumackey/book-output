module RequestHelper
  def login
    user = create(:user, email:'test@test.jp', password: 'password', password_confirmation: 'password')
    post '/login', params: { login_form: { 
      email: 'test@test.jp',
      password: 'password',
    } }
    follow_redirect!
    user
  end
end
