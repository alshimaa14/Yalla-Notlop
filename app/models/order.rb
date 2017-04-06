class Order < ApplicationRecord
  belongs_to :user
  MEAL_OPTIONS = %w(Breakfast Lunch Dinner)
  #attr_accessor :count

  validates :meal, :inclusion => {:in => MEAL_OPTIONS}

  #paperclip
  has_attached_file :menu, styles: { large:"600x600", medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :menu, content_type: /\Aimage\/.*\z/


  has_many :order_friend_invitations
  has_many :invited_friends, :through => :order_friend_invitations

  has_many :items
end
