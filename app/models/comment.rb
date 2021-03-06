class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :message, presence: true
  validates :post_id, presence: true
  validates :user_id, presence: true
  paginates_per 10
end
