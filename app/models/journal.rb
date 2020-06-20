class Journal < ApplicationRecord
  belongs_to :user
  has_many :entries, :dependent => :destroy

  validates :user_id, presence: true
  default_scope -> { order(title: :asc) }
  validates :title,
    :presence => {:message => " can't be blank."},
    length: {minimum: 1, maximum: 25, 
      :message => " must be between 1 and 25 characters."}

end
