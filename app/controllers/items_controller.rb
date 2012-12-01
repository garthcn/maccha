class ItemsController < ApplicationController

  #before_filter :authenticate_user!, :except => [:index, :show, :search]

  # GET /items
  # GET /items.json
  def index
    @page = (params[:page] || 1).to_i
    @items_per_page = (params[:num] || 50).to_i
    # @items = Item.all
    results = Item.search("", @page, @items_per_page)
    @items = results[0]
    @count = results[1]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @transaction = Transaction.new
    @item = Item.find(params[:id])
    @seller = User.find(@item.seller_id)

		if user_signed_in?
			#create new bid entry regardless of whether
			#the buyer have already bid or not
			@bid = @item.bids.build

			#search the buyer's previous bid
			@bid_existing = Bid.user_highest_bid(@item.id,current_user.id)
		end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def search
    @keywords = params[:keywords]
    if not @keywords.nil?
      if not @keywords.strip.empty?
        @page = (params[:page] || 1).to_i
        @items_per_page = (params[:num] || 50).to_i
        results = Item.search(@keywords, @page, @items_per_page)
        @items = results[0]
        @count = results[1]
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @items }
        end
      else
        redirect_to request.referer || :root
      end
    else
      redirect_to :root
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    t_start = params[:item][:start_time].to_date.to_s + ' ' + params[:start_hour]
    t_end = params[:item][:end_time].to_date.to_s + ' ' + params[:end_hour]
    params[:item][:start_time] = DateTime.parse(t_start)
    params[:item][:end_time] = DateTime.parse(t_end)
    params[:item][:start_time] = params[:item][:start_time].change(:offset => "-5")
    params[:item][:end_time] = params[:item][:end_time].change(:offset => "-5")

    @item =  Item.new(params[:item])
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def apply_to_delete
    @item = Item.find(params[:item_id])
    reason = params[:delete_reason] || ''
    respond_to do |format|
      if @item.update_attributes(delete_request: true, delete_reason: reason)
        format.html { redirect_to @item,
          notice: 'Application submitted. Please wait for confirmation.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @item,
          notice: 'There was something wrong. Application was not submitted.' }
        format.json { head :no_content }
      end
    end
  end

  # for testing
  def delete_item
    @item = Item.find(params[:item_id])
    respond_to do |format|
      if @item.update_attributes(is_deleted: true, delete_request: false)
        @item.bids.each do |b|
          b.update_attributes(status: 101)
        end
        format.html { redirect_to @item, notice: 'Item deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to @item, notice: 'Item not deleted.' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  # def destroy
  #   @item = Item.find(params[:id])
  #   @item.destroy
  #   respond_to do |format|
  #     format.html { redirect_to items_url }
  #     format.json { head :no_content }
  #   end
  # end
end
