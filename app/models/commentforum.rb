class Commentforum < ApplicationRecord
  belongs_to :forumpost
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :reply,
  :presence => {:message => " can't be blank."},
  length: {minimum: 1, maximum: 2000, 
    :message => " must be between 1 and 2000 characters."}
end
