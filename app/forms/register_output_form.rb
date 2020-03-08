class RegisterOutputForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question, :string
  attribute :choice1, :string
  attribute :choice2, :string
  attribute :choice3, :string
  attribute :choice4, :string

  # def question_params
  #   params
  # end
end