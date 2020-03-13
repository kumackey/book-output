class RegisterOutputForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Validations

  attribute :question, :string
  attribute :correct_choice, :string
  attribute :incorrect_choice_1, :string
  attribute :incorrect_choice_2, :string
  attribute :incorrect_choice_3, :string

  validates :question, presence: true, length: { maximum: 500 }
  validates :correct_choice, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_1, presence: true, length: { maximum: 40 }
  validates :incorrect_choice_2, length: { maximum: 40 }
  validates :incorrect_choice_3, length: { maximum: 40 }

  def save_question_and_choices(user, book)
    output = user.outputs.build(content: self.question)
    output.book_id = book.id
    output.save

    correct_choice = output.choices.build(content: self.correct_choice)
    correct_choice.is_answer = true
    correct_choice.save

    output.choices.create(content: self.incorrect_choice_1)
    output.choices.create(content: self.incorrect_choice_2)
    output.choices.create(content: self.incorrect_choice_3)
  end
end
