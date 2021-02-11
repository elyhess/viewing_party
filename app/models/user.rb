class User < ApplicationRecord
  validates :email, presence: true,
                    format: { with: /\A[^@\s]+@[^@\s]+\z/, message: ', you must use a valid email address' }
  validates :password, presence: true

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
  has_many :inverse_friendships,
           class_name: 'Friendship',
           foreign_key: 'friend_id',
           dependent: :destroy,
           inverse_of: :friend
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :parties, dependent: :destroy
  has_many :party_guests, dependent: :destroy

  has_secure_password

  before_save do
    email.downcase!
  end

  def all_friends
    friends + inverse_friends
  end

  def no_friends?
    friends.none? && inverse_friends.none?
  end

  def party_invites
    Party.joins(:party_guests).where('party_guests.user_id = ?', Current.user.id)
  end
end
