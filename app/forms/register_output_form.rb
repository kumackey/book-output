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

  VALID_ANSWER_NUMBER_REGEX = /[1-4]/
  validates :answer_number, presence: true
  validates_format_of :answer_number, with: VALID_ANSWER_NUMBER_REGEX
  # def question_params
  #   params
  # end
end