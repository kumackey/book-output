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

  validates :question, presence: true, length: { maximum: 500 }
  validates :choice_1, presence: true, length: { maximum: 40 }
  validates :choice_2, presence: true, length: { maximum: 40 }
  validates :choice_3, length: { maximum: 40 }
  validates :choice_4, length: { maximum: 40 }

  validates :answer_number, presence: true
  VALID_ANSWER_NUMBER_REGEX = /[1-4]/.freeze
  validates_format_of :answer_number, with: VALID_ANSWER_NUMBER_REGEX

  def choices
    array = []
    array << self.choice_1
    array << self.choice_2
    array << self.choice_3
    array << self.choice_4
    array
  end
end
