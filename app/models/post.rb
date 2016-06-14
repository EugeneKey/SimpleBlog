class Post < ActiveRecord::Base
  acts_as_taggable
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, length: { minimum: 3, maximum: 255 }, uniqueness: true, presence: true
  validates :body, :user_id, presence: true

  default_scope { order('created_at') }

  scope :publishing, -> { where(publish: true) }

  scope :user_posts, -> (current_user) { where(user: current_user) }
end
