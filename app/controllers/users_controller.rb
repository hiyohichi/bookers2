class UsersController < ApplicationController
  #  アクセス制限
  before_action :is_matching_login_user,only: [:edit,:update]
  before_action :authenticate_user!, only: [:show]



  def index
    @users=User.all
    @user=current_user
    @book=Book.new
    @books=Book.all
  end

  def show
    @user=User.find(params[:id])
    @books=@user.books.all
    @book=Book.new
    #DM機能
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end
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
      redirect_to current_user
    end
  end

end
