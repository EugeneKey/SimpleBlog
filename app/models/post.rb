class Post < ActiveRecord::Base
  validates :title, length: { minimum: 3, maximum: 255 }, uniqueness: true, presence: true
  validates :body, presence: true
end
