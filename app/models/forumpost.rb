class Forumpost < ApplicationRecord
  has_many :comments
  belongs_to :user
  acts_as_taggable_on :tags
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  
  validates :content,
    :presence => {:message => " can't be blank."},
    length: {minimum: 1, maximum: 500, 
      :message => " must be between 1 and 500 characters."}

  validates :title,
  :presence => {:message => " can't be blank."},
  length: {minimum: 1, maximum: 25, 
    :message => " must be between 1 and 25 characters."}
end
