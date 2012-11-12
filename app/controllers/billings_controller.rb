class BillingsController < ApplicationController

  def create
    if current_user
      params[:billing][:user_id] = current_user.id
      @billing = Billing.new(params[:billing])
      if @billing.save
        flash[:success] = 'Billing info updated.'
      else
        flash[:alert] = 'Failed to update billing info.'
      end
      redirect_to user_path(current_user)
    else
      redirect_to :root
    end
  end

  def update
    if current_user
      @billing = current_user.billing
      if @billing.update_attributes(params[:billing])
        flash[:success] = 'Billing info updated.'
      else
        flash[:alert] = 'Failed to update billing info.'
      end
      redirect_to user_path(current_user)
    else
      redirect_to :root
    end
  end
end
