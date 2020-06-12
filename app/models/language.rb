class Language < ApplicationRecord
    has_many :fluencies
    has_many :users, through: :fluencies
end
