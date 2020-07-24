class User < ApplicationRecord
  include Clearance::User

  after_initialize :set_defaults, unless: :persisted?
  before_create :confirmation_token

  has_many :commentforums
  has_many :fluencies
  has_many :languages, through: :fluencies
  
  accepts_nested_attributes_for :languages
  accepts_nested_attributes_for :fluencies, allow_destroy: true

  has_many :journals, :dependent => :destroy
  has_many :forumposts, :dependent => :destroy
  has_many :forumpostlikes, :dependent => :destroy
  has_many :commentforumlikes, dependent: :destroy
  has_many :entries, through: :journals
  has_many :entrylikes, :dependent => :destroy
  has_many :corrections, :dependent => :destroy

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                  foreign_key: "followed_id",
                                  dependent: :destroy
  has_many :followers, through: :passive_relationships
  has_many :following, through: :active_relationships, source: :followed

  validates :firstname,  
    :presence => {:message => " can't be blank."},
    length: { minimum: 1, maximum: 25, 
      :message => " must be between 1 and 25 letters."
    }

  validates_format_of :firstname, :with => /\A[a-z]+\z/i, 
    message: " must not contain any numbers."

  validates :lastname,  
    presence: true, 
    length: { minimum: 1, maximum: 25, 
      :message => " must be between 1 and 25 letters."
  }

  validates_format_of :lastname, :with => /\A[a-z]+\z/i,
    message: " must not contain any numbers."

  validates :password, 
    length: {minimum:4, :message => " must be at least four characters."}

  def set_defaults
    self.points = 0 if self.points.nil?
    self.tagarray = [] if self.tagarray.nil?
  end
  
  class << self
  def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def confirm_email!
    Notifier.deliver_welcome(self)
    super
  end

  def add_tag(tag)
    self.tagarray = [] if self.tagarray == nil
    update_attributes tagarray: self.tagarray + [ tag ]
  end

  def confirmation_token
    if  self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end 

  module Validations
    extend ActiveSupport::Concern

    included do
      validates :email,
        email: { strict_mode: true },
        :presence => {:message => "Email can't be blank."},
        uniqueness: { allow_blank: true },
        unless: :email_optional?

      validates :password, 
        :presence => {:message => "Password can't be blank."},
        unless: :skip_password_validation?
      end
    end
  end
end
