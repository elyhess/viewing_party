class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :users_are_not_already_friends?

  def users_are_not_already_friends?
    if friend == user
      errors.add(:user_id, 'You Cannot Add Yourself')
    elsif user.all_friends.include?(friend)
      errors.add(:user_id, "You're already friends with this person.")
    end
  end
end
