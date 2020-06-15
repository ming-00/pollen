class Language < ApplicationRecord
    has_many :fluencies
    has_many :users, through: :fluencies

    validates :lang, uniqueness: true

    accepts_nested_attributes_for :fluencies, allow_destroy: true
end
