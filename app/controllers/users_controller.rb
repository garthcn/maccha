class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def plans
    @buyer_plans = [
      {name: "No Plan", price: 0,
        features: ["Shipping varies by item", "Return varies by item"]},
      {name: "Maccha Basic", price: 5,
        features: ["Flat-rate Shipping ($4.99)",
          "Easy Returns (vary by item)"]},
      {name: "Maccha Limited", price: 10,
        features: ["Flat-rate Shipping ($4.99)",
          "Free Returns (within 30 days)"]},
      {name: "Maccha Unlimited", price: 15,
        features: ["Free 2-day Shipping",
          "Free Returns (within 365 days)"]}
    ]
    @seller_plans = [
      {name: "No Plan", price: 0,
        features: ["Feature a", "Feature b", "Feature c"]},
      {name: "Maccha Bronze", price: 15,
        features: ["Feature 1", "Feature 2", "Feature 3"]},
      {name: "Maccha Silver", price: 25,
        features: ["Feature 4", "Feature 5", "Feature 6"]},
      {name: "Maccha Gold", price: 40,
        features: ["Feature 7", "Feature 8", "Feature 9"]}
    ]

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
    @user_type = UserType.find_by_user_id(params[:id])
    @seller_type = @user_type ? @user_type.seller_type : 'default'
    @buyer_type = @user_type ? @user_type.buyer_type : 'default'
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
