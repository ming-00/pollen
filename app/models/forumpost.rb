class Forumpost < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  
  validates :content,
    :presence => {:message => " can't be blank."},
    length: {minimum: 1, maximum: 500, 
      :message => " must be between 1 and 500 characters."}
end
