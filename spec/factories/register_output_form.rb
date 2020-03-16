FactoryBot.define do
  factory :register_output_form do
    question_content { "学校補助金の増額案に対する賛成票は、ある投票所では優位に多かった。どこか？" }
    commentary { "プライミング効果によって、学校に対して有利な投票をしたくなるため"}
    user_id { 1 }
    book_id { 1 }
    correct_choice { "学校" }
    incorrect_choice_1 { "市役所" }
    incorrect_choice_2 { "警察署" }
    incorrect_choice_3 { "美術館" }
  end
end