module WebNotification
  module Generators
    class NotificationPackageGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :website_name, type: :string, optional: false, banner: ""
      argument :website_service_url, type: :string, optional: false, banner: ""
      argument :website_push_id, type: :string, optional: false, banner: ""
      argument :website_allowed_domain, type: :string, optional: false, banner: ""
      argument :website_url_formatted_string, type: :string, optional: false, banner: ""
      argument :wwdr_certificate_path, type: :string, optional: false, banner: "Absolute path to your WWDR certification file"
      argument :key_path, type: :string, optional: false, banner: "Absolute path to your p12 file"
      argument :cert_password, type: :string, default: '', optional: true, banner: "Password for your P12 certificate"

      desc 'Creating controller, routes and package generator files'
      def create_initializer_file
        template 'web_notification_package_initializer.rb', File.join('config', 'initializers', "web_notification_package_initializer.rb")
        template 'apple_web_notifications_controller.rb', File.join('app', 'controllers', "apple_web_notifications_controller.rb")
        route "delete '/v1/devices/:device_token/registrations/:web_push_id', :controller => :apple_web_notifications, :action => :add_device, :constraints => { :web_push_id => /[^\/]+/ }"
        route "post '/v1/devices/:device_token/registrations/:web_push_id', :controller => :apple_web_notifications, :action => :delete_device, :constraints => { :web_push_id => /[^\/]+/ }"
        route "post '/v1/pushPackages/:web_push_id', :controller => :apple_web_notifications, :action => :package, :constraints => { :web_push_id => /[^\/]+/ }"
        route "post '/v1/log', :controller => :apple_web_notifications, :action => :log"
        template 'website.json', File.join('notification', 'web_package', "website.json")
        directory 'icon.iconset', File.join('notification', 'web_package', 'icon.iconset')
      end
    end
  end
end