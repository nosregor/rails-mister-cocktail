class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, :through => :dose

  validates :name, uniqueness: true, presence: true
end

