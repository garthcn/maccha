class BidsController < ApplicationController
  def index
    if current_user
      @user_bids = current_user.bids
      render 'index'
    else
      redirect_to :root
    end
  end

  def new
    @bid = Bid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bid }
    end
  end
  def create
    #start_datetime = params[:Bid][:start_date] + ' ' +  params[:Bid][:start_time]
    #params[:Bid][:start_time] = DateTime.parse(start_datetime)
    #end_datetime = params[:Bid][:end_date] + ' ' + params[:Bid][:end_time]
    #params[:Bid][:end_time] = DateTime.parse(end_datetime)
    #@bid_existing=Bid.find_by_item_id_and_buyer_id(params[:bid][:item_id],params[:bid][:buyer_id])
    @item = Item.find(params[:bid][:item_id])
    #if          @bid_existing.nil?
    #@bid = Bid.new(params[:bid])
    #else
    #end
    #  print "new #{current_user.id}"
    price = @item.bids.maximum(:price) || @item.price
    params[:bid][:price] = params[:bid][:price].to_f.round(2)
    if params[:bid][:price] < price
    else
      @bid = @item.bids.build(params[:bid])
    end
    # if  ( !@item.bids.maximum(:price).nil?)
    #   if params[:bid][:price] < @item.bids.maximum(:price)
    #   else
    #     @bid  =  @item.bids.build (params[:bid])
    #   end
    # elsif params[:bid][:price] < @item.price
    # else
    #   @bid  =  @item.bids.build (params[:bid])
    # end
    respond_to do |format|
      if !@bid.nil? && @bid.save
        print " test1 #{@bid.attributes_before_type_cast["created_at"]}"
        print " test2 #{@bid.created_at}"
        format.html { redirect_to @item, notice: 'Bid was successfully created.' }
        format.json { render json: @bid, status: :created, location: @bid }
      else
        format.html { redirect_to @item, notice: 'Error! Bid was not created. Bid should be higher than current price!' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @bid_existing=Bid.find(params[:id])
    @item = Item.find(params[:bid][:item_id])
    respond_to do |format|
      if  params[:bid][:price].to_f <  @item.bids.maximum(:price)
        format.html { redirect_to @item, notice: 'Bid not updated ! You should bid more than current price!.' }
        else

      if @bid_existing.update_attributes(params[:bid])
        format.html { redirect_to @item, notice: 'Bid was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy

    # @bid=Bid.find_by_item_id_and_buyer_id(params[:bid][:item_id],params[:bid][:buyer_id])
    @bid_existing=Bid.find(params[:id])
    @item = Item.find(@bid_existing.item_id)
    @bid_existing.destroy

    respond_to do |format|
      format.html { redirect_to @item, notice: 'Bid was successfully deleted.'  }
      format.json { head :no_content }
    end
  end
  def search

  end
  def find
    @items = Item.find_by(params[:bid][:item_id])
  end

  def apply_to_cancel
    @bid = Bid.find(params[:bid_id])
    @item = @bid.item
    reason = params[:cancel_reason] || ''
    respond_to do |format|
      if @bid.update_attributes(cancel_request: true, cancel_reason: reason)
        format.html { redirect_to @item, notice: 'Application submitted. Please wait for confirmation.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @item, notice: 'There was something wrong. Application was not submitted.'  }
        format.json { head :no_content }
      end
    end
  end
end
