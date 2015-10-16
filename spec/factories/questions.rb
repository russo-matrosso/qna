FactoryGirl.define do
    factory :question do
      title "My qeustion title"
      body "My qeustion body"
    end

  factory :invalid_question, class: 'Question' do
    title ""
    body "Text"
  end

end
