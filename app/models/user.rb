class User < ApplicationRecord
  include Clearance::User

  has_many :fluencies
  has_many :languages, through: :fluencies

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
