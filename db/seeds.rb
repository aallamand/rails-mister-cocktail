# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'json'

json = open("http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list").read
parsed_json = JSON.parse(json)
parsed_json["drinks"].each do |ingredient|
  Ingredient.create(name: ingredient['strIngredient1'])
end

100.times do
  url_cocktail = open('http://www.thecocktaildb.com/api/json/v1/1/random.php').read
  parsed_cocktail = JSON.parse(url_cocktail)
  parsed_cocktail["drinks"].each do |information|
    url = information["strDrinkThumb"]
    cocktail = Cocktail.new(name: information['strDrink'])
    cocktail.remote_photo_url = url
    cocktail.save
    i = 1
    while i < 15 do
      ingredient_recipe = Ingredient.find_by name: information["strIngredient#{i}"]
      ingredient_recipe
      dose = Dose.new(description: information["strMeasure#{i}"])
      dose.ingredient = ingredient_recipe
      dose.cocktail = cocktail
      dose.save
      i += 1
    end
  end
end
