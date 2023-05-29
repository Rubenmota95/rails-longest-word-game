require "open-uri"

class GamesController < ApplicationController

def new
  @alphabet = ("A".."Z").to_a
  @letters = 10.times.map { @alphabet.sample }
end

def score
  @answer = ""
  @used = []
  @word_array = params[:word].split("")
  @word_array.each do |letter|
    if params[:letters].downcase.include?(letter)
      @used << letter
      params[:letters].downcase.delete(letter)
    end
  end
  url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
  words_serialized = URI.open(url).read
  @word = JSON.parse(words_serialized)
  if @word["found"] == true && @used.size == params[:word].size
    @answer = "Well done! '#{params[:word].capitalize}' is a valid word!"
  else
    @answer = "Game over! '#{params[:word].capitalize}' is not a valid word!"
  end
end
end
