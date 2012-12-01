namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    require 'date'
    
    [Item].each(&:delete_all)
    [Bid].each(&:delete_all)
    [Transaction].each(&:delete_all)
  end
end

