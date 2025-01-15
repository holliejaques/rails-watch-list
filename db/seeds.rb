# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# require 'faker'
require 'open-uri' # reads an api
require 'json' # formats everything correctly

puts 'Cleaning up database...'
Movie.destroy_all
puts 'Database cleaned'

url = 'http://tmdb.lewagon.com/movie/top_rated'

12.times do |i|
  puts "Importing movies from page #{i + 1}"
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    puts "Creating #{movie['title']}"
    base_poster_url = 'https://image.tmdb.org/t/p/original'
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "#{base_poster_url}#{movie['backdrop_path']}",
      rating: movie['vote_average']
    )
  end
end

puts "#{Movie.count} movies created"

# Movie.destroy_all

# 20.times do
#   Movie.create(
#     title: Faker::Movie.title,
#     overview: Faker::Lorem.paragraphs,
#     poster_url: Faker::LoremFlickr.image,
#     rating: Faker::Number.between(from: 1, to: 5)
#   )
# end
