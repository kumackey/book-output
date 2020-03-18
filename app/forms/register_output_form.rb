class RegisterOutputForm
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
  validates :commentary, length: { maximum: 140 }
  validates :correct_choice, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_1, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_2, length: { maximum: 40 }
  validates :incorrect_choice_3, length: { maximum: 40 }
  validates :user_id, presence: true
  validates :book_id, presence: true

  def save_question_and_choices
    user = User.find(user_id)
    question = user.questions.build(content: question_content, commentary: commentary, book_id: book_id)
    question.save # 問題文と解説文の保存

    choice = question.choices.build(content: correct_choice)
    choice.is_answer = true
    choice.save # 正解選択肢の保存

    question.choices.create(content: incorrect_choice_1)
    question.choices.create(content: incorrect_choice_2)
    question.choices.create(content: incorrect_choice_3)
  end
end
