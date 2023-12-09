class FavoritesController < ApplicationController

  def create
    @book=Book.find(params[:book_id])
    favorite=current_user.favorites.new(book_id: @book.id)
    favorite.save
    # create.js.erb
  end

  def destroy
    @book=Book.find(params[:book_id])
    favorite=current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
  # destroy.js.erb
  end

end