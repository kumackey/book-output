class CreateQuizChoiceForm
  #  4択クイズを作るときのフォーム

  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question_content, :string
  attribute :commentary, :string
  attribute :correct_choice, :string
  attribute :incorrect_choice_1, :string
  attribute :incorrect_choice_2, :string
  attribute :incorrect_choice_3, :string
  attribute :user_id, :integer
  attribute :book_id, :integer

  validates :question_content, presence: true, length: { maximum: 140 }
  validates :commentary, length: { maximum: 255 }
  validates :correct_choice, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_1, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_2, length: { maximum: 40 }
  validates :incorrect_choice_3, length: { maximum: 40 }
  validates :user_id, presence: true
  validates :book_id, presence: true

  def save
    return false unless valid?

    user = User.find(user_id)
    question = user.questions.build(
      content: question_content,
      commentary: commentary,
      book_id: book_id,
      answer_type: :choice
    )
    return false unless question.valid?

    ActiveRecord::Base.transaction do
      question.save!
      question.choices.create!(content: correct_choice, is_answer: true)
      question.choices.create!(content: incorrect_choice_1)
      question.choices.create(content: incorrect_choice_2) #  2,3は必須ではないのでエラーにしない
      question.choices.create(content: incorrect_choice_3)
    end
    true
  end
end
