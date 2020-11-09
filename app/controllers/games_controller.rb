 require 'open-uri'
 
 class GamesController < ApplicationController
  def valid_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end
  
    def included?(guess, grid)
      guess.chars.all? { |letter| guess.count(letter) <= grid.length}
    end
  
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score 
    @word = params[:answer]
    @letters = params[:letters]
    if included?(@word, @letters)
      if valid_word?(@word)
        @message = "Congratulation! #{@word} is a valid word"
        @points = @word.length
      else
        @message = "#{@word} is not a valid word"
      end
    else 
      @message = "Sorry but #{@word} cannot be made from #{@letters}"
    end
  end
end