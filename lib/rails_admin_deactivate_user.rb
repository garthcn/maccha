require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'
 
module RailsAdminDeactivateUser
end
 
module RailsAdmin
  module Config
    module Actions
      class DeactivateUser < Base
        # RailsAdmin::Config::Actions.register(self)

        # register_instance_option :visible? do
        #   authorized? && !bindings[:object].approved
        # end

        # register_instance_option :member do
        #   true
        # end
        register_instance_option :bulkable? do
          true
        end

        # register_instance_option :link_icon do
        #   'icon-check'
        # end

        register_instance_option :controller do
          Proc.new do
            # @object.update_attribute(:cancel_request, true)
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)

            # Update field published to true
            @objects.each do |object|
              object.update_attribute(:cancel_request, false)
              object.update_attribute(:deactivated, true)
            end
            flash[:notice] = "User(s) deactivated."
            redirect_to back_or_index
          end
        end
      end
    end
  end
end

