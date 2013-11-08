Apple Safari Web Push Notification Gem for Rails
=================================

Apple Web Push Notifications

## Usage

### Install

```
gem 'web-push-notification-rails'
bundle install
```

### P12 certificate
This the first of 2 certificates you need to sign.
[Apple has a step-by-step] for most of it. You can pick up from step 7.
Alternatively, you can follow all of my steps:

1. Go to <b>[iOS Provisioning Portal]</b> (you need to login or register)
* Click on <b>"Website Push IDs"</b> on the left side menu
* Click on <b>"New Website Push ID"</b> and fill in the 2 fields
* After you come back to the listing of website push ids, select the created Push Id and click on <b>"Edit"</b> and then <b>"Create Certificate..."</b>
* Follow the steps on <b>About Creating a Certificate Signing Request (CSR)</b>
* Once you <b>download</b> the Certficate.cer, double-click to <b>install</b>
* In the "Keychain Access" tool <b>right-click</b> on Website Push ID: <web.company.id> and select both and right click <b>"Export 2 items...</b>
* Change "File Format" to "Personal Information Exchange(.p12)" and <b>save</b> (preferably to Rails.root/cert/)
* The password you enter during the saving process will go into the initializer ("Run Generator" step)

### WWDR Certificate
Second certificate you need to sign the web package

1. <b>Download</b> http://developer.apple.com/certificationauthority/AppleWWDRCA.cer
* Double-click to <b>install</b>
* In the "Keychain Access" tool <b>right-click</b> on "Apple Worldwide Developer Relations Certification Authority" and click on <b>Export "Apple....</b>
* Change "File Format" to "Privacy Enhanced Mail (.pem)" and <b>save</b> it (preferably to Rails.root/cert/)

### Run generators
All the <b>parameters are optional</b>. You can just edit the initializer later
```
   rails g web_notification:notification_package website_name website_service_url website_push_id website_allowed_domain website_url_formatted_string wwdr_certificate_path key_path [cert_password]
```

Example:
```
   rails g web_notification:notification_package mixtapp https://www.mixtapp.co web.com.encoredevlabs.mixtapp https://www.mixtapp.co "https://www.mixtapp.co?%@" cert/AppleWWDRCA.cer cert/website_aps_production.cer.p12 password
```
If password is blank do not enter the last parameter: cert_password and a blank password will be used.

### Customize
If you need to change the password or location of the certificates later you can change it in the web_notification_package_initializer.rb file.

The package sent to Apple is inside `notfication/web_package` folder in Rails.root. Customize the icons inside icon.iconset folder. You can also customize the `website.json` which was genereated using the values specified in the generator. Checkout the Apple documentation link below to see what values you need to set in the json file.

### Apple Callback to Controller
All request from Apple regarding the web package will be sent to `apple_web_notifications_controller.rb` which you can customize or you can change the generated routes in the routes.rb file and send the Apple callback methods to your desired controller.

You will need to implement what needs to be done once you get the device token from Apple.

If you have any questions or need help, find me on Twitter: @ankurpatel

[Safari Push Notification]: https://developer.apple.com/notifications/safari-push-notifications/
[iOS Provisioning Portal]: https://developer.apple.com/devcenter/ios/index.action
[Apple WWDC Session Video]: https://developer.apple.com/wwdc/videos/index.php?id=614
[Apple documentation]: https://developer.apple.com/library/mac/documentation/NetworkingInternet/Conceptual/NotificationProgrammingGuideForWebsites/PushNotifications/PushNotifications.html
