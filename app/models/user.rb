class User < ApplicationRecord
  include Clearance::User

  validates :firstname,  
    :presence => {:message => "First name can't be blank."},
    length: { minimum: 1, maximum: 25, 
      :message => "First name must be between 1 and 25 letters."
    }

  validates_format_of :firstname, :with => /\A[a-z]+\z/i, 
    message: "First name must not contain any numbers."

  validates :lastname,  
    presence: true, 
    length: { minimum: 1, maximum: 25, 
      :message => "First name must be between 1 and 25 letters."
  }

  validates_format_of :lastname, :with => /\A[a-z]+\z/i,
    message: "Last name must not contain any numbers."

end
