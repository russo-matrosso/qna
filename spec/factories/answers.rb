FactoryGirl.define do
  factory :answer do
    body "My answer text"
    question ''
    user {create(:user)}
  end

  factory :invalid_answer, class: 'Answer' do
    body ''
  end

end
