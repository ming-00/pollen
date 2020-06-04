class User < ApplicationRecord
  include Clearance::User

  validates :firstname,  presence: true, length: { minimum: 1, maximum: 25 }
  validates :firstname,  presence: true, length: { minimum: 1, maximum: 25 }

end
