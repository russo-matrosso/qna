require 'rails_helper'

RSpec.describe FavouriteQuestion, type: :model do
  it {should belong_to :question}
  it {should belong_to :user}
end
