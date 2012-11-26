class TransactionsController < ApplicationController

  def index
    user = User.find_by_id(params[:id])
    @transactions = user.transactions
    
    respond_to do |format|
      format.xml { render :xml => @transactions.to_xml }
      format.json { render :json => @transactions.to_json }
    end
  end

  def create
    if !current_user.billing.billing_valid?
      flash[:alert] = 'Please complete your billing information first'
      redirect_to user_path(current_user)
    else
      @item = Item.find_by_id(params[:item_id])
      transaction_params = {
        :seller_id => params[:seller_id],
        :buyer_id => current_user.id,
        :item_id => params[:item_id],
        :price => @item.price,
        :is_shipped => true
      }
      @transaction = Transaction.new(transaction_params)

      if @transaction.save
        flash[:success] = 'You have bought the item. It will be shipped to your address.'
        @item.is_sold = true
        @item.save
      else
        flash[:alert] = 'Transaction rejected.'
      end
      redirect_to item_path(@item) 
    end
  end
end
