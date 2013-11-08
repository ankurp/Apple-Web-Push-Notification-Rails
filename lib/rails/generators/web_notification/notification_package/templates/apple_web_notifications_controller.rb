class AppleWebNotificationsController < ApplicationController
  
  def add_device
    puts params
    # add your code to add device
    render json: {}
  end

  def delete_device
    puts params
    # add your code to add device
    render json: {}
  end

  def package
    packaged_data = WebNotification::NotificationPackage.instance.generate_with_auth_token(SecureRandom.base64)
    response.headers["last-modified"] = Time.zone.now.strftime("%Y-%m-%d %H:%M:%S")
    send_data(packaged_data.sysread, :type => 'application/zip', :disposition => 'inline', :filename => "package.zip") and return
  end

  def log
    puts params
    # errors are sent here
    render json: {}
  end

end