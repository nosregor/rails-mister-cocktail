class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates :description, presence: true
  #validates :cocktail_id, :uniqueness => { :scope => :ingredient_id }

  #validates :description, :cocktail, :ingredient, :presence => true
  validates :cocktail, uniqueness: { scope: :ingredient, case_sensitive: false, message: "You can't repeat an ingredient for the same cocktail!" }

end


#, :message: 'cant store this ingredient for this coctail twice'
