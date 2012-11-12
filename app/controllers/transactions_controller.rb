class TransactionsController < ApplicationController

  def create
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
      flash[:success] = 'You have bought the item.'
    else
      flash[:alert] = 'Transaction rejected.'
    end
    redirect_to item_path(@item) 
  end
end
