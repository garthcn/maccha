class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def plans

  end

  def profile
    if user_signed_in?
      redirect_to user_path(current_user)
    else
      redirect_to :root
    end
  end
    
  def show
    @user = User.find_by_id(params[:id]) || not_found
    @user_type = UserType.find_by_user_id(params[:id])
    @seller_type = @user_type ? @user_type.seller_type : 'default'
    @buyer_type = @user_type ? @user_type.buyer_type : 'default'
  end
end
