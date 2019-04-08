require 'rest-client'
require 'json'
require 'pry'

#At last page
#response_hash["next"] == nil - no more pages
#response_hash["count"] == 87 - total character entrys

def get_character_movies_from_api(character_name)
  #make the web request

  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  counter = 1
  films = []


  while films.size <= 1 do

    response_hash["results"].find do |item_name|

      if item_name["name"].downcase == character_name.downcase
        films = item_name["films"]
        puts "Film found"
        films.collect! do |film_url|
          response_film_url = RestClient.get(film_url)
          response_film_url_hash = JSON.parse(response_film_url)
          response_film_url_hash["title"]
        end
        puts "Film Convert"
        return films
      elsif response_hash["next"] == nil
        return puts "Character not found."
      end

    counter += 1

    response_string = RestClient.get(response_hash["next"])
    response_hash = JSON.parse(response_string)
  end
end


  #films = []
  #response_hash["results"].find do |item_name|
  #
  #  if item_name["name"].downcase == character_name.downcase
  #    films = item_name["films"]
  #  end
  #end

  #if response_hash["results"][0]["name"].downcase == character_name
  #  films = response_hash["results"][0]["films"]
  #end

  #films.collect! do |film_url|
  #  response_film_url = RestClient.get(film_url)
  #  response_film_url_hash = JSON.parse(response_film_url)
  #  response_film_url_hash["title"]
  #end




  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |title|
    puts title
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
