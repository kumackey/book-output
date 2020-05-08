class OnlyAnswerQuizForm
  #  問題と解答だけのフォームを作成

  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question_content, :string
  attribute :commentary, :string
  attribute :answer_content, :string
  attribute :user_id, :integer
  attribute :book_id, :integer

  validates :question_content, presence: true, length: { maximum: 140 }
  validates :commentary, length: { maximum: 255 }
  validates :answer_content, presence: true, length: { maximum: 40 }
  validates :user_id, presence: true
  validates :book_id, presence: true
end
