class Forumpost < ApplicationRecord
  belongs_to :user
  has_many :commentforums
  has_many :forumpostlikes, dependent: :destroy
  TAGS = ['Spanish', 'German', 'Japanese', 'French', 'Korean', 'Grammar', 'Vacabulary']
  acts_as_taggable_on :tags
  acts_as_punchable
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  after_initialize :set_defaults, unless: :persisted?

  def self.search(params)
    forumposts = Forumpost.where("title LIKE ? or content LIKE ?", "%#{params[:search]}%",
                "%#{params[:search]}%") if params[:search].present?
    forumposts
  end
  
  validates :content,
    :presence => {:message => " can't be blank."},
    length: {minimum: 1, maximum: 500, 
      :message => " must be between 1 and 500 characters."}

  validates :title,
  :presence => {:message => " can't be blank."},
  length: {minimum: 1, maximum: 200, 
    :message => " must be between 1 and 201 characters."}

    def set_defaults
      self.accepted = false if self.accepted.nil?
    end
end
