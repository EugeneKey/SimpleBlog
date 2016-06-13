require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :post_id }
  it { should belong_to :post }
  it { should validate_presence_of :user_id }
  it { should belong_to :user }
end
