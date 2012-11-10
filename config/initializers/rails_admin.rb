
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
end