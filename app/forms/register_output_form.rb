class RegisterOutputForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question_content, :string
  attribute :correct_choice, :string
  attribute :incorrect_choice_1, :string
  attribute :incorrect_choice_2, :string
  attribute :incorrect_choice_3, :string
  attribute :user_id, :integer
  attribute :book_id, :integer

  validates :question_content, presence: true, length: { maximum: 500 }
  validates :correct_choice, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_1, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_2, length: { maximum: 40 }
  validates :incorrect_choice_3, length: { maximum: 40 }

  def save_question_and_choices
    user = User.find(user_id)
    book = Book.find(book_id)
    question = user.questions.build(content: question_content)
    question.book_id = book.id
    question.save

    correct_choice = question.choices.build(content: self.correct_choice)
    correct_choice.is_answer = true
    correct_choice.save

    question.choices.create(content: incorrect_choice_1)
    question.choices.create(content: incorrect_choice_2)
    question.choices.create(content: incorrect_choice_3)
    question
  end
end
