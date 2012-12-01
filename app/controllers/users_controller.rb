class UsersController < ApplicationController
  def index
  end

  def plans
    @buyer_plans = buyer_plans
    @seller_plans = seller_plans

    @billing = nil
    @no_billing = false
    @user_type = nil

    if user_signed_in?
      uid = current_user.id
      @billing = Billing.find_by_user_id(uid)
      @user_type = UserType.find_by_user_id(uid)
    end
    if @billing.nil?
      @billing = Billing.new
      @no_billing = true
    end
    if @user_type.nil?
      @seller_type = 0
      @buyer_type = 0
    else
      @seller_type = @user_type.seller_type || 0
      @buyer_type = @user_type.buyer_type || 0
    end
    @buyer_plan = @buyer_plans[@buyer_type]
    @seller_plan = @seller_plans[@seller_type]
  end

  def profile
    if user_signed_in?
      redirect_to user_path(current_user)
      @user = User.find(current_user[:id])
      # @user_type = UserType.find_by_user_id(current_user[:id])
      @user_type = @user.user_type
      @seller_type = @user_type ? @user_type.seller_type : 'default'
      @buyer_type = @user_type ? @user_type.buyer_type : 'default'
    else
      redirect_to :root
    end
  end
    
  def show
    @user = User.find_by_id(params[:id]) || not_found
    @user_billing = @user.billing

    @user_bids = []
    @user_all_bids = @user.bids
    # Remove lower bids for the user
    @user_all_bids.group_by(&:item_id).select do |item_id, item_bids|
      max_bid = item_bids.max_by { |x| x.price }
      @user_bids << max_bid
    end

    @user_transactions = @user.transactions
    @user_items_for_sale = @user.items_for_sale

    @user_type = UserType.find_by_user_id(params[:id])
    @seller_type = @user_type ? seller_plans[@user_type.seller_type][:name] : 'default'
    @buyer_type = @user_type ? buyer_plans[@user_type.buyer_type][:name] : 'default'
  end

  def activate_type
    if user_signed_in? and (not current_user.billing.nil?)
      uid = current_user.id
      prms = {user_id: uid}
      buyer_type = params[:buyer_type].to_i || 0
      seller_type = params[:seller_type].to_i || 0
      @user_type = UserType.find_by_user_id(uid)
      type_existed = (not @user_type.nil?)

      # if buyer_type > 0
      #   prms[:buyer_type] = buyer_type
      # end
      # if seller_type > 0
      #   prms[:seller_type] = seller_type
      # end

      result = true
      if type_existed
        if buyer_type > 0
          prms[:buyer_type] = buyer_type
        end
        if seller_type > 0
          prms[:seller_type] = seller_type
        end
        result = @user_type.update_attributes(prms)
      else
        prms[:buyer_type] = buyer_type
        prms[:seller_type] = seller_type
        @user_type = UserType.new(prms)
        result = @user_type.save
      end

      respond_to do |format|
        if result
          format.html { redirect_to plans_url, notice: 'Plan was successfully activated.' }
          format.json { render json: {code: "0", message: "Plan was successfully activated."}, status: :ok }
        else
          format.html { redirect_to plans_url, notice: 'Plan was NOT successfully activated.' }
          format.json { render json: {code: "1", errors: @user_type.errors}, status: :ok }
        end
      end
    else
      respond_to do |format|
        if user_signed_in?
          format.html { redirect_to plans_url, notice: 'Please fill in your billing info first.' }
          format.json { render json: {code: "10", message: 'Please fill in your billing info first.'}, status: :ok }
        else
          format.html { redirect_to plans_url, notice: 'You need to sign in.' }
          format.json { render json: {code: "10", message: 'You need to sign in.'}, status: :ok }
        end
      end
    end
  end

  def deactivate_type
    if user_signed_in?
      uid = current_user.id
      prms = {user_id: uid}
      buyer_type = params[:buyer_type].to_i || 0
      seller_type = params[:seller_type].to_i || 0
      @user_type = UserType.find_by_user_id(uid)
      if not @user_type.nil?
        if buyer_type > 0
          prms[:buyer_type] = 0
        end
        if seller_type > 0
          prms[:seller_type] = 0
        end
        # @user_type.update_attributes(prms)
      end

      respond_to do |format|
        if @user_type and @user_type.update_attributes(prms)
          format.html { redirect_to plans_url, notice: 'Plan was successfully deactivated.' }
          format.json { render json: {code: "0", message: "Plan was successfully deactivated."}, status: :ok }
        else
          format.html { redirect_to plans_url, notice: 'Plan was NOT successfully deactivated.' }
          format.json { render json: {code: "1", errors: @user_type.errors}, status: :ok }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to plans_url, notice: 'You need to sign in.' }
        format.json { render json: {code: "10", message: 'You need to sign in.'}, status: :ok }
      end
    end
	end

	def apply_to_cancel
		@user = User.find(current_user.id)
    reason = params[:cancel_reason] || ''
    respond_to do |format|


      if @user.update_with_password({cancel_request: true, cancel_reason: reason})
        format.html { redirect_to edit_user_registration_path, notice: 'Application submitted. Please wait for confirmation.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_user_registration_path, notice: 'There was something wrong. Application was not submitted.'  }
        format.json { head :no_content }
      end
    end
  end


  def check_id
    u = User.find_by_email(params[:user_email])
    if u
      render :text => u.id
    else
      render :text => '-1'
    end
  end
  
end
