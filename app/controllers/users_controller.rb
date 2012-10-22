class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def plans
    
  end
end
