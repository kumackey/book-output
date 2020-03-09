FactoryBot.define do
  factory :register_output_form do
    question { "学校補助金の増額案に対する賛成票は、ある投票所では優位に多かった。どこか？" }
    choice_1 { "市役所" }
    choice_2 { "学校" }
    choice_3 { "警察署" }
    choice_4 { "美術館" }
    answer_number { 1 }
  end
end