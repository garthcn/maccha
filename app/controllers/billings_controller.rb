class BillingsController < ApplicationController
  def create
    if user_signed_in?
      buyer_type = params[:buyer_type].to_i || 0
      seller_type = params[:seller_type].to_i || 0
      uid = current_user.id
      prms = {user_id: uid}
      ut_status = false
      @user_type = UserType.find_by_user_id(uid)
      if @user_type.nil?
        @user_type = UserType.new(buyer_type: buyer_type,
                                  seller_type: seller_type,
                                  user_id: uid)
        ut_status = @user_type.save
      else
        if buyer_type > 0
          prms[:buyer_type] = buyer_type
        end
        if seller_type > 0
          prms[:seller_type] = seller_type
        end
        ut_status = @user_type.update_attributes(prms)
      end
      @billing = Billing.new(params[:billing])

      respond_to do |format|
        if @billing.save and ut_status
          format.html { redirect_to plans_url, notice: 'Plan was successfully activated.' }
          format.json { render json: @billing, status: :created, location: @billing }
        else
          format.html { redirect_to plans_url, notice: 'Plan was NOT successfully activated.' }
          format.json { render json: @billing.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to plans_url, notice: 'You need to sign in.' }
        format.json { render json: {message: 'You need to sign in.'}, status: :ok }
      end
    end
  end

  def update
    if user_signed_in?
      buyer_type = params[:buyer_type].to_i || 0
      seller_type = params[:seller_type].to_i || 0
      uid = current_user.id
      prms = {user_id: uid}
      ut_status = false
      @user_type = UserType.find_by_user_id(uid)
      if @user_type.nil?
        @user_type = UserType.new(buyer_type: buyer_type,
                                  seller_type: seller_type,
                                  user_id: uid)
        ut_status = @user_type.save
      else
        if buyer_type > 0
          prms[:buyer_type] = buyer_type
        end
        if seller_type > 0
          prms[:seller_type] = seller_type
        end
        ut_status = @user_type.update_attributes(prms)
      end

      @billing = Billing.find_by_user_id(uid)

      respond_to do |format|
        if @billing.update_attributes(params[:billing])
          format.html { redirect_to plans_url, notice: 'Plan was successfully activated.' }
          format.json { head :no_content }
        else
          format.html { redirect_to plans_url, notice: 'Plan was NOT successfully activated.' }
          format.json { render json: @billing.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to plans_url, notice: 'You need to sign in.' }
        format.json { render json: {message: 'You need to sign in.'}, status: :ok }
      end
    end
  end

  def destroy
    if user_signed_in?
      @billing = Billing.find(params[:id])
      @billing.destroy

      respond_to do |format|
        format.html { redirect_to plans_url }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to plans_url, notice: 'You need to sign in.' }
        format.json { render json: {message: 'You need to sign in.'}, status: :ok }
      end
    end
  end
end
