class BooksController < ApplicationController
  def new
    @book=Book.new
  end
  
  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :new
    end 
  end 
  
  def index
    @books=Book.all
    @book=Book.new
    @user=User.find(current_user.id)
  end

  def show
    @book=Book.find(params[:id])
    @book_new=Book.new
  end

  def edit
    @book=Book.find(params[:id])
  end
  
  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title,:body,:image)
  end
end
