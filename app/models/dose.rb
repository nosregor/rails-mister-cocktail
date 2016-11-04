class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates :description, presence: true
  validates :cocktail_id, :uniqueness => { :scope => :ingredient_id}

end


#, :message: 'cant store this ingredient for this coctail twice'
