class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  has_many :orders

  has_many :friendships
  has_many :friends, :through => :friendships

  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  #searchkick word_start: [:email, :name]

  has_many :order_friend_invitations

  #has_many :invited, :class_name => "OrderFriendInvitation", :foreign_key => "friend_id"
  #has_many :order_invites, :through => :order_invitations, :source => :order_friend_invites

  has_many :items

  has_many :notifications

  # group and members
  has_many :groups
  has_many :members
end
