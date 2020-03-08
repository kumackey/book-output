class RegisterOutputForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question, :string
  attribute :choice_1, :string
  attribute :choice_2, :string
  attribute :choice_3, :string
  attribute :choice_4, :string
  attribute :answer_number, :integer

  validates :answer_number, presence: true
  # def question_params
  #   params
  # end
end