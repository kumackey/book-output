class RegisterOutputForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question, :string
  attribute :choice_1, :string #これを配列として取得する
  attribute :choice_2, :string
  attribute :choice_3, :string
  attribute :choice_4, :string
  attribute :answer_number, :integer

  validates :question, presence: true, length: { maximum: 500 }
  validates :choice_1, presence: true, length: { maximum: 40 }
  validates :choice_2, presence: true, length: { maximum: 40 }
  validates :choice_3, length: { maximum: 40 }
  validates :choice_4, length: { maximum: 40 }

  validates :answer_number, presence: true
  VALID_ANSWER_NUMBER_REGEX = /[1-4]/
  validates_format_of :answer_number, with: VALID_ANSWER_NUMBER_REGEX
  # def question_params
  #   params
  # end
end