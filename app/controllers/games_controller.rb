require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
  random_letters = ('a'..'z').to_a
  @dictionary_letters = random_letters.sample(10)
  @dictionary_letters
  end


  def score
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    word_serialized = URI.open(url).read
    dictionary_check = JSON.parse(word_serialized)

    letters = params[:dictionary_letters].split(' ')
    word = params[:word].chars

    word.each do |letter|
      if letters.include?(letter)
        letters.delete(letter)
    end
  end
  # raise

# if the word you've inputted is a correct dictionary word AND
# if the letters you've inputted are equal to the letters provided
# then your score = "Congratulations!

if letters.length == (10 - word.length) && dictionary_check["found"] == true
  @score = "Congratulations!"
elsif letters.length != (10 - word.length) && dictionary_check["found"] == true
  @score = "Sorry but #{word.join} can't be built out of the letters provided"
elsif dictionary_check["found"] == false
  @score = "Sorry but #{word.join}  is invalid"
else
  @score = "ERROR"
end
end
end
