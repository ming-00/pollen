class Entry < ApplicationRecord
  belongs_to :journal
  default_scope -> { order(created_at: :desc) }

  validates :title,
    :presence => {:message => " can't be blank."},
    length: {minimum: 1, maximum: 25, 
      :message => " must be between 1 and 25 characters."}

  validates :content,
    :presence => {:message => " can't be blank."},
    length: {minimum: 20, maximum: 2000, 
      :message => " must be between 20 and 2000 characters."}
end
