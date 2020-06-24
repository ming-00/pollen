class Correction < ApplicationRecord
  belongs_to :entry

  validates :entry, presence: true
  validates :content, presence: true
end
