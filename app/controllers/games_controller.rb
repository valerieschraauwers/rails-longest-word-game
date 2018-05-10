class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params[:userword].upcase!
    @letters = params[:letters]
    @english_word = english_word?(@word)
    @included = included?(@word, @letters)
  end

private

def included?(guess, grid)
  guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
end

def english_word?(word)
  response = RestClient.get("https://wagon-dictionary.herokuapp.com/#{word}")
  json = JSON.parse(response.body)
  return json['found']

end

end
