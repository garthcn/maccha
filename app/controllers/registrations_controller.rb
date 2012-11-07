class RegistrationsController < Devise::RegistrationsController
  def update
    # If password is not changed, just fill it with current password
    if params[:user][:password].blank?
      params[:user][:password] = params[:user][:current_password]
      params[:user][:password_confirmation] = params[:user][:current_password]
    end

    @user = User.find(current_user.id)
    if @user.update_with_password(params[:user])
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to user_path(current_user)
    else
      render "edit"
    end
  end
end
