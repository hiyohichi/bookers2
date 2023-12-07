class BooksController < ApplicationController
  def new
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id

    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books=Book.all
      @user=current_user
      render :index
    end
  end

  def index
    @books=Book.all
    @book=Book.new
    @user=current_user
  end

  def show
    @book=Book.find(params[:id])
    @book_new=Book.new
    @user=@book.user
    @books=@user.books.all
    @book_comment=BookComment.new
    @book_comments=BookComment.all
  end

  def edit
    is_matching_login_user
    @book=Book.find(params[:id])
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path
    else
      render :edit
    end
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

  def is_matching_login_user

    book=Book.find(params[:id])

    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
