class Commentforum < ApplicationRecord
  belongs_to :forumpost
  belongs_to :user
  has_many :commentforumlikes, dependent: :destroy
  default_scope -> { order(acceptedscore: :desc, created_at: :desc) }
  after_initialize :set_defaults, unless: :persisted?
  
  validates :reply,
  :presence => {:message => " can't be blank."},
  length: {minimum: 1, maximum: 2000, 
    :message => " must be between 1 and 2000 characters."}

    def set_defaults
      self.accepted = false if self.accepted.nil?
      self.acceptedscore = 0 if self.acceptedscore.nil?
    end
end
