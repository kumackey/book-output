class LoginForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :email, :string
  attribute :password, :string

  validates :email, presence: true
  validates :password, presence: true
end
