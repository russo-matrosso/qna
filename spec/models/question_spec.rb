require 'rails_helper'

RSpec.describe Question, type: :model do
  it {should validate_presence_of :title}
  it {should validate_presence_of :body}

  it {should belong_to :user}
  it {should have_many :answers}
  it {should have_many :attachments}
  it {should have_many :votes}
  it {should have_many :favourite_questions}
  it {should have_many :favourited_by}

  it {should accept_nested_attributes_for :attachments}
end
