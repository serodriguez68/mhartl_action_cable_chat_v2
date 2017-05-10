class Message < ApplicationRecord
  belongs_to :user
  validates :content, presence: true
  scope :for_display, -> { order(:created_at).last(50) }

  # Returns a list of users @mentioned in message content.
  def mentions
    mentions = content.scan(/@(#{User::NAME_REGEX})/).flatten
    User.where(username: mentions)
  end

end
