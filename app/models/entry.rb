class Entry < ApplicationRecord
  belongs_to :journal
  belongs_to :user, optional: true
  
  has_many :corrections, :dependent => :destroy
  default_scope -> { order(created_at: :desc) }

  validates :title,
    :presence => {:message => " can't be blank."},
    length: {minimum: 1, maximum: 35, 
      :message => " must be between 1 and 35 characters."}

  validates :content,
    :presence => {:message => " can't be blank."},
    length: {minimum: 20, maximum: 2000, 
      :message => " must be between 20 and 2000 characters."}
end
