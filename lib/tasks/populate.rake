namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    require 'date'
    
    [Item].each(&:delete_all)
    
    #Category.populate 20 do |category|
      #category.name = Populator.words(1..3).titleize
      #Product.populate 10..100 do |product|
        #product.category_id = category.id
        #product.name = Populator.words(1..5).titleize
        #product.description = Populator.sentences(2..10)
        #product.price = [4.99, 19.95, 100]
        #product.created_at = 2.years.ago..Time.now
      #end
    #end
    
    Item.populate 50 do |item|
      item.name         = Faker::Lorem.words(3)
      item.price        = 199
      item.start_time   = Date.today
      item.end_time     = Date.tomorrow
      item.category     = Faker::Lorem.words(2)
      item.condition    = Faker::Lorem.words(1)
      item.location     = Faker::Address.city
      item.description  = Faker::Lorem.sentences(5)
      item.seller_id    = 3
    end
  end
end
