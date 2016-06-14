class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, length: { minimum: 3, maximum: 255 }, uniqueness: true, presence: true
  validates :body, :user_id, presence: true

  scope :publishing, -> { where(publish: true) }
end
