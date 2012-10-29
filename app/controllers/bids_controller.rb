class BidsController < ApplicationController
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
    @item = Item.find(params[:bid][:item_id])
    #@bid = Bid.new(params[:bid])
    @bid  =  @item.bids.build (params[:bid])

    #  print "new #{current_user.id}"
    respond_to do |format|
      if @bid.save
        print " test1 #{@bid.attributes_before_type_cast["created_at"]}"
        print " test2 #{@bid.created_at}"
        format.html { redirect_to @item, notice: 'Bid was successfully created.' }
        format.json { render json: @bid, status: :created, location: @bid }
      else
        format.html {redirect_to @item, notice: 'Error! Bid was not created.'  }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end
  def search

  end
  def find
    @items = Item.find_by(params[:bid][:item_id])
  end
end
