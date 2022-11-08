require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    # array of 10 random letters
    # new @letters instance variable to store random letters  from alphabet
    @letters = []
    i = 0
    until i == 10
      letter = ("A".."Z").to_a.sample
      @letters << letter
      i += 1
    end
  end

  def score
    # if params[:score]
    @word_herokuapp = params[:score].upcase

    # split white spaces
    @split_words_herokuapp = @word_herokuapp.split(//)
    @letters = params[:letters].split(//)
    if @split_words_herokuapp - @letters == []
      url = "https://wagon-dictionary.herokuapp.com/#{@word_herokuapp.downcase}"
      user_serialised = URI.open(url).read
      @user = JSON.parse(user_serialised)
      if @user["found"] == true
        @message = "Congratulations! '#{@word_herokuapp.capitalize}' is a valid English word!"
      else
        @message = "Sorry but '#{@word_herokuapp.capitalize}' does not seem to be a valid English word..."
      end
    else
      @message = "Sorry but '#{@word_herokuapp.capitalize}' can't be built out of #{@letters.join("")}"
    end
    # end
  end
end
