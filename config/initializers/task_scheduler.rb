require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

#scheduler.in '20m' do
#  puts "order ristretto"
#end

#scheduler.at 'Thu Mar 26 07:31:43 +0900 2009' do
  #puts 'order pizza'
#end

# Bid status: 
# 1 - winner
# 2 - loser
scheduler.cron '01 00 * * 1-7' do
  # every day of the week at 12:01 am 

  #puts 'update bid.status to 2 (end)'
  @expired_bids = Bid.where(" expired_at <= :end_date", {:end_date => Time.now})

  #@expired_bids = Bid.all
  @expired_bids.group_by(&:item_id).each do |item_id, bids|
    bids.each do |bid|
      bid.status = 2
      bid.save
    end
    max_bid = bids.max_by { |b| b.price }
    max_bid.status = 1
    max_bid.save

    losing_ids = bids.map { |b| b.buyer_id }
    winning_id = [max_bid.buyer_id]
    losing_ids = losing_ids - winning_id
    #p "#{item_id} -- #{losing_ids} -- #{winning_id}"
    
    item = Item.find_by_id(item_id)
    item.winner_id = max_bid.buyer_id 
    item.save

    # Send winner email
    winner = User.find_by_id(winning_id)
    NotifyMailer.buyer_win_auction(item, winner).deliver

    # Send losers email
    losing_ids.each do |id|
      loser = User.find_by_id(id)
      NotifyMailer.buyer_lost_auction(item, loser).deliver
    end

    # Send seller email
    seller = User.find_by_id(item.seller_id)
    NotifyMailer.seller_auction_result(seller, max_bid).deliver
  end

end

#scheduler.every '5m' do
 # puts 'check blood pressure'
  #end

