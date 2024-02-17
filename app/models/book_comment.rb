class BookComment < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications

  validates :comment,presence:true
  
  private
  def create_notifications
    Notification.create(subject: self, end_user: post_workout.end_user, action_type: :commented_to_own_post)
  end
end
