# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Cocktail.destroy_all
# Ingredient.destroy_all

# puts "Creating cocktails"

# cocktails = [
#   {
#     name: "Old Fashioned",
#     picture: "http://www.seriouseats.com/images/2014/11/20141104-cocktail-party-old-fashioneds-holiday-vicky-wasik-3.jpg"
#     },
#   {
#     name: "Daiquiri",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-daiquiri.jpg"
#     },
#   {
#     name: "Margarita",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-margarita.jpg"
#     },
#   {
#     name: "Sidecar",
#     picture: "http://www.seriouseats.com/images/2014/11/20141101-cognac-sidecar-carey-jones.jpg"
#     },
#   {
#     name: "French 75",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-french75.jpg"
#     },
#   {
#     name: "Bloody Mary",
#     picture: "http://www.seriouseats.com/images/2015/03/twase-20150320-21.jpg"
#     },
#   {
#     name: "Irish Coffee",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-irish-coffee.jpg"
#     },
#   {
#     name: "Jack Rose",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-jack-rose.jpg"
#     },
#   {
#     name: "Negroni",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-negroni.jpg"
#     },
#   {
#     name: "Boulevardier",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-boulevardier.jpg"
#     },
#   {
#     name: "Sazerac",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-sazerac.jpg"
#     },
#   {
#     name: "Vieux Carré",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-vieux-carre.jpg"
#     },
#   {
#     name: "Ramos Gin Fizz",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-robyn-lee-ramos-gin-fizz.jpg"
#     },
#   {
#     name: "Mint Julep",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-mint-julep.jpg"
#     },
#   {
#     name: "Whiskey Sour",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-whiskey-sour.jpg"
#     },
#   {
#     name: "Mai Tai",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-mai-tai.jpg"
#     },
#   {
#     name: "Planter's Punch",
#     picture: "http://www.seriouseats.com/images/2015/04/20150406-cocktails-planters-punch-robyn-lee-1.jpg"
#     },
#   {
#     name: "Pisco Sour",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-pisco-sour.jpg"
#     },
#   {
#     name: "Cosmopolitan",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-cosmopolitan.jpg"
#     },
#   {
#     name: "Tom Collins",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-tom-collins.jpg"
#     },
#   {
#     name: "Last Word",
#     picture: "http://www.seriouseats.com/images/2015/03/20150323-cocktails-vicky-wasik-last-word.jpg"
#   }
# ]

# ingredients = %w(lemon ice mint leaves redbull jagermeister sugar tonic gin rhum)
# ingredients.each { |ingredient| Ingredient.create(name: ingredient) }


# cocktails.each { |cocktail| Cocktail.create(cocktail) }


require 'rest-client'
require 'json'

cocktail_rows = 100
ingredients_url = "http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
cocktail_random_url = "http://www.thecocktaildb.com/api/json/v1/1/random.php"

def get_json(url)
 JSON.parse(RestClient.get(url))
end

puts "Creating rows for Ingredients"
get_json(ingredients_url)["drinks"].each do |ingredient|
 Ingredient.create(name: ingredient["strIngredient1"])
end

puts "Adding #{cocktail_rows} rows to Cocktails"
cocktail_rows.times do
 cocktail_hash = get_json(cocktail_random_url)["drinks"][0]
 cocktail_obj = Cocktail.create(name: cocktail_hash["strDrink"], remote_picture_url: cocktail_hash["strDrinkThumb"])

 15.times do |n|
   index_number = n + 1
   ingredient_name = cocktail_hash["strIngredient#{index_number}"]
   description = cocktail_hash["strMeasure#{index_number}"]
   unless ingredient_name.nil? || ingredient_name.empty?
     ingredient = Ingredient.where(name: ingredient_name).first
     Dose.create(description: description.strip , ingredient: ingredient, cocktail: cocktail_obj)
   end
 end
end
