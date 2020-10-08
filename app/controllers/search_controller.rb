class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @word = params[:keyword]
    @range = params[:range]
    @search = params[:search]
    if @range == '1'
      @user = User.search(@word,@search)
      @users = User.all
    else
      @book = Book.search(@word,@search)
      @books = Book.all
    end
  end
end