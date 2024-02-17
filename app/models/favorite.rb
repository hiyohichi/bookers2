class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications

  validates :user_id,uniqueness: {scope: :book_id}
  
  private
  def create_notifications
    Notification.create(subject: self, user: self.post_workout.user, action_type: :liked_to_own_post)
  end

end
