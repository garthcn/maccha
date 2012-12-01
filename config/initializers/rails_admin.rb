require Rails.root.join('lib', 'rails_admin_deactivate_user.rb')

RailsAdmin.config do |config|
  #config.current_user_method do
    #authenticate_or_request_with_http_basic do |username, password|
     # username == "admin" && password == "adminpass"
   # end
  #  FakeUser
 # end
 # config.main_app_name { ['Recommended Games', 'Admin'] }
  #config.authenticate_with{}
  config.authorize_with do
      authenticate_or_request_with_http_basic('Site Message') do |username, password|
        username == 'admin' && password == 'adminpass'
      end
  end
  config.main_app_name { ['Recommended Games', 'Admin'] }

  module RailsAdmin
    module Config
      module Actions
        class DeactivateUser < Base
          RailsAdmin::Config::Actions.register(self)
        end
        class DeactivateUsers < Base
          RailsAdmin::Config::Actions.register(self)
        end
        class ReactivateUsers < Base
          RailsAdmin::Config::Actions.register(self)
        end
        class RemoveItems < Base
          RailsAdmin::Config::Actions.register(self)
        end
        class RemoveItem < Base
          RailsAdmin::Config::Actions.register(self)
        end
        class AddItemsBack < Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end

  config.actions do
    dashboard
    index
    new
 
    show
    edit
    delete
 
    remove_item do
      visible do
        bindings[:abstract_model].model.to_s == "Item"
      end 
    end
    remove_items do
      visible do
        bindings[:abstract_model].model.to_s == "Item"
      end 
    end
    add_items_back do
      visible do
        bindings[:abstract_model].model.to_s == "Item"
      end 
    end
    deactivate_user do
      visible do
        bindings[:abstract_model].model.to_s == "User"
      end 
    end
    deactivate_users do
      visible do
        bindings[:abstract_model].model.to_s == "User"
      end 
    end
    reactivate_users do
      visible do
        bindings[:abstract_model].model.to_s == "User"
      end 
    end
  end

end
