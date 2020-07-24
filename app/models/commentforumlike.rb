class Commentforumlike < ApplicationRecord
  belongs_to :commentforum
  belongs_to :user
end
