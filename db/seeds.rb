# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'json'

URL = "https://tmdb.lewagon.com/movie/top_rated"

Movie.destroy_all

raw_movies = URI.open(URL).read
movies = JSON.parse(raw_movies)["results"]
  puts movies

movies.each do |movie|
  puts "Creating #{movie['title']}"
  Movie.create(
    title: movie['original_title'],
    overview: movie['overview'],
    rating: movie['vote_average'],
    poster_url: "https://image.tmdb.org/t/p/original#{movie['poster_path']}"
  )
end

puts 'Movies created'
