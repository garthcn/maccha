class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def plans

  end
    
  def show
    if user_signed_in?
      @user = User.find(current_user[:id])
      @user_type = UserType.find_by_user_id(current_user[:id])
      @seller_type = @user_type ? @user_type.seller_type : 'default'
      @buyer_type = @user_type ? @user_type.buyer_type : 'default'
    else
      redirect_to :root
    end
  end
end
