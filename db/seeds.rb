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
parsed_json.each do |key, value|
  value.each do |e|
    e.each do |key, value|
      ingredient = Ingredient.new(name: "#{value}")
      ingredient.save
    end
  end
end
