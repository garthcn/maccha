class RegistrationsController < Devise::RegistrationsController
  #def update
    #p "$$$$$$$$$"
    #@user = User.find(current_user.id)
    #password_changed = !params[:user][:password].empty?
  
    #params[:user].delete("current_password")

    #successfully_updated = if password_changed
      #@user.update_with_password(params[:user])
    #else
      #@user.update_without_password(params[:user])
    #end

    #if successfully_updated
      ## Sign in the user bypassing validation in case his password changed
      #sign_in @user, :bypass => true
      #redirect_to root_path
    #else
      #render "edit"
    #end
  #end

  def update
    p '############'
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_without_password(params[:user])

      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to user_path(current_user)
    else
      render "edit"
    end
  end
end
