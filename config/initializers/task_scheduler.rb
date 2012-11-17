require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new

#scheduler.in '20m' do
#  puts "order ristretto"
#end

#scheduler.at 'Thu Mar 26 07:31:43 +0900 2009' do
  #puts 'order pizza'
#end

scheduler.cron '01 00 * * 1-7' do
  # every day of the week at 22:00 (10pm)
  puts 'update bid.status to 2 (end)'
  @bids=Bid.where(" expired_at <= :end_date", {:end_date =>Time.now})
  @bids.each do |bid|
    bid.status=2
    bid.save
  end
end

#scheduler.every '5m' do
 # puts 'check blood pressure'
  #end

