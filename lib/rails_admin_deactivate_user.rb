require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

# require 'action_view/helpers/output_safety_helper'
require 'active_support/core_ext/string/output_safety'
 
module RailsAdminDeactivateUser
end
module RailsAdminDeactivateUsers
end
module RailsAdminReactivateUsers
end
module RailsAdminRemoveItem
end
module RailsAdminRemoveItems
end
module RailsAdminAddItemsBack
end
 
module RailsAdmin
  module Config
    module Actions
      class ReactivateUsers < Base
        # RailsAdmin::Config::Actions.register(self)

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)
            @objects.each do |object|
              # object.update_attribute(:cancel_request, false)
              object.update_attribute(:deactivated, false)
            end
            flash[:notice] = "User(s) re-activated."
            redirect_to back_or_index
          end
        end
      end

      class DeactivateUsers < Base
        # RailsAdmin::Config::Actions.register(self)

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)
            @objects.each do |object|
              object.update_attribute(:cancel_request, false)
              object.update_attribute(:deactivated, true)
            end
            flash[:notice] = "User(s) deactivated."
            redirect_to back_or_index
          end
        end
      end

      class DeactivateUser < Base
        # RailsAdmin::Config::Actions.register(self)

        # register_instance_option :visible? do
        #   authorized? && !bindings[:object].approved
        # end

        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'icon-minus-sign'
        end

        register_instance_option :controller do
          Proc.new do
            bids = @object.bids
            items = @object.items
            unfinished_bids = []
            unfinished_items = []
            pending_bids = []
            pending_items = []
            bids.each do |b|
              if b.item && b.item.end_time < Time.now
                unfinished_bids << b
                pending_bids << "Bid ##{b.id}"
              end
            end
            items.each do |item|
              if item.end_time < Time.now
                unfinished_items << item
                pending_items << "Item ##{item.id}"
              end
            end

            suc = true
            flash[:notice] = ""
            if not unfinished_bids.empty?
              flash[:notice] << "<strong>[ERROR]</strong>" +
                'The user has pending bids. You have to ' +
                'wait until the auction is over, or delete pending bids or ' +
                'the corresponding items. <br>Pending bids: ' +
                pending_bids.join(", ") + "<br>"
              suc = false
            end
            if not unfinished_items.empty?
              flash[:notice] << "<strong>[ERROR]</strong>" +
                "The user has pending items. You have to " +
                "wait until the auction is over, or delete the pending items." +
                "<br>Pending items: " + pending_items.join(", ") + "<br>"
              suc = false
            end
            if (suc)
              @object.update_attribute(:cancel_request, false)
              @object.update_attribute(:deactivated, true)
              flash[:notice] = "User deactivated."
            else
              flash[:notice] = flash[:notice].html_safe
            end
            redirect_to back_or_index
          end
        end
      end

      class RemoveItems < Base
        # RailsAdmin::Config::Actions.register(self)

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)
            @objects.each do |object|
              object.update_attribute(:delete_request, false)
              object.update_attribute(:is_deleted, true)
            end
            flash[:notice] = "Item(s) removed."
            redirect_to back_or_index
          end
        end
      end

      class RemoveItem < Base
        # RailsAdmin::Config::Actions.register(self)

        # register_instance_option :visible? do
        #   authorized? && !bindings[:object].approved
        # end

        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'icon-minus-sign'
        end

        register_instance_option :controller do
          Proc.new do
            @object.update_attribute(:delete_request, false)
            @object.update_attribute(:is_deleted, true)
            flash[:notice] = "Item removed."
            redirect_to back_or_index
          end
        end
      end

      class AddItemsBack < Base
        # RailsAdmin::Config::Actions.register(self)

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :controller do
          Proc.new do
            # Get all selected rows
            @objects = list_entries(@model_config, :destroy)
            @objects.each do |object|
              # object.update_attribute(:delete_request, false)
              object.update_attribute(:is_deleted, false)
            end
            flash[:notice] = "Item(s) activated."
            redirect_to back_or_index
          end
        end
      end
    end
  end
end

