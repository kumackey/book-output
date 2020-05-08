FactoryBot.define do
  factory :only_answer_quiz_form do
    question_content { '学校補助金の増額案に対する賛成票は、ある投票所では優位に多かった。どこか？' }
    commentary { 'プライミング効果によって、学校に対して有利な投票をしたくなるため' }
    answer_content { '学校' }
    book_id { create(:book).id }
    user_id { create(:user).id }
  end
end
