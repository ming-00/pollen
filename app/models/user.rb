class User < ApplicationRecord
  include Clearance::User

  validates :firstname,  presence: true, length: { minimum: 1, maximum: 25 }
  validates_format_of :firstname, :with => /\A[a-z]+\z/i
  validates :lastname,  presence: true, length: { minimum: 1, maximum: 25 }
  validates_format_of :lastname, :with => /\A[a-z]+\z/i

end
