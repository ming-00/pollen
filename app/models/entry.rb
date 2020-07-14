class Entry < ApplicationRecord
  after_initialize :set_defaults, unless: :persisted?
  acts_as_punchable

  belongs_to :journal
  belongs_to :user, optional: true
  
  has_many :corrections, :dependent => :destroy
  default_scope -> { order(created_at: :desc) }

  has_many :entrylikes, :dependent => :destroy

  validates :title,
    :presence => {:message => " can't be blank."},
    length: {minimum: 1, maximum: 70, 
      :message => " must be between 1 and 70 characters."}

  validates :content,
    :presence => {:message => " can't be blank."},
    length: {minimum: 20, maximum: 2000, 
      :message => " must be between 20 and 2000 characters."}

  def set_defaults
    self.resolved = false if self.resolved.nil?
  end
end
