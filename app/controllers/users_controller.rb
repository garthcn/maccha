class UsersController < ApplicationController
  def index
    @users = User.all
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
      @seller_type = @user_type.seller_type
      @buyer_type = @user_type.buyer_type
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
    @user_bids = @user.bids
    @user_transactions = @user.transactions
    @user_type = UserType.find_by_user_id(params[:id])
    @seller_type = @user_type ? seller_plans[@user_type.seller_type][:name] : 'default'
    @buyer_type = @user_type ? buyer_plans[@user_type.buyer_type][:name] : 'default'
  end

  def activate
    buyer_type = params[:buyer_type]
    seller_type = params[:seller_type]
    # @b = Bid.new(params)
    # @b.save
  end

  def deactivate
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
        @user_type.update_attributes(prms)
      end

      respond_to do |format|
        if @user_type.update_attributes(prms)
          format.html { redirect_to plans_url, notice: 'Plan was successfully deactivated.' }
          format.json { render json: {code: "0", message: "Plan deactivated"}, status: :ok }
        else
          format.html { redirect_to plans_url, notice: 'Plan was NOT successfully deactivated.' }
          format.json { render json: {code: "1", errors: @user_type.errors}, status: :ok }
        end
      end
    else
      format.html { redirect_to plans_url, notice: 'You need to sign in.' }
      format.json { render json: {code: "10", message: 'You need to sign in.'}, status: :ok }
    end
  end
end
