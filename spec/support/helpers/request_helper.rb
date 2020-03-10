module RequestHelper
  def login
    create(:user, email:'guest@guest.jp', password: 'password', password_confirmation: 'password')
    post '/login', params: { login_form: { 
      email: 'guest@guest.jp',
      password: 'password',
    } }
    follow_redirect!
  end
end