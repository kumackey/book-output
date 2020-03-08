FactoryBot.define do
  factory :register_output_form do
    question { "学校補助金の増額案に対する賛成票は、ある投票所では優位に多かった。どこか？" }
    choice1 { "市役所" }
    choice2 { "学校" }
    choice3 { "警察署" }
    choice4 { "美術館" }
  end
end