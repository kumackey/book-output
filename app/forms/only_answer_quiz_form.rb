class OnlyAnswerQuizForm
  #  問題と解答だけのフォーム

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

  def save
    return false unless valid?

    user = User.find(user_id)
    question = user.questions.build(
      content: question_content,
      commentary: commentary,
      book_id: book_id,
      answer_type: 1
    )
    return false unless question.valid?

    ActiveRecord::Base.transaction do
      question.save! # 問題文と解説文の保存
      answer = question.build_answer(content: answer_content)
      answer.save!
      true
    end
  end
end
