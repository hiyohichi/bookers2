class UsersController < ApplicationController
  #  アクセス制限
  before_action :is_matching_login_user,only: [:edit,:update]



  def index
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
    @books=@user.books.all
    @book=Book.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    @user.update
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def book_params
    params.require(:book).permit(:title,:body,:image)
  end

  def is_matching_login_user
    user=User.find(params[:id])
    unless user.id == current_user.id
      redirect_to books_path
    end
  end

end
