class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def plans

  end
    
  def show
    @user = User.find(params[:id])
    @user_type = UserType.find_by_user_id(params[:id])
    @seller_type = @user_type ? @user_type.seller_type : 'default'
    @buyer_type = @user_type ? @user_type.buyer_type : 'default'
  end
end
