class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates :title, length: { minimum: 3, maximum: 255 }, uniqueness: true, presence: true
  validates :body, presence: true
end
