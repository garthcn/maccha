class WatchListsController < ApplicationController
  def index
    @watch_lists = current_user.watch_lists
    @items = @watch_lists.map { |watch_list|
      Item.find_by_id(watch_list.item_id)
    }
    @page = (params[:page] || 1).to_i
    @items_per_page = (params[:num] || 50).to_i
    #@items = results[0]
    @count = @items.size
  end

  def create
    watch_list = current_user.watch_lists.build(:item_id => params[:item_id].to_i) 
    watch_list.save
    respond_to do |format|
      format.html { redirect_to item_path(params[:item_id]) }
      format.js
    end
  end

  def destroy
    watch_list = current_user.watch_lists.find_by_item_id(params[:item_id])
    watch_list.destroy
    respond_to do |format|
      format.html { redirect_to item_path(params[:item_id]) }
      format.js
    end
  end
end
