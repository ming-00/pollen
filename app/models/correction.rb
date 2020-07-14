class Correction < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?

  belongs_to :entry
  belongs_to :user

  validates :entry_id, presence: true
  validates :user_id, presence: true
  validates :content,
  :presence => {:message => " can't be blank."}

  default_scope -> { order(created_at: :desc) }

  has_many :correctionlikes, :dependent => :destroy

  def set_defaults
    self.correct = false if self.correct.nil?
    self.accepted = false if self.accepted.nil?
  end
end
