class Fluency < ApplicationRecord
  belongs_to :user
  belongs_to :language
  # new
  accepts_nested_attributes_for :language

  validates :user, presence: true
  validates :language, presence: true
end
