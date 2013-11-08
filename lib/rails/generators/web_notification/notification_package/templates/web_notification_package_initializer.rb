require 'openssl'

WebNotification::NotificationPackage.instance.configure do |package|
  package.wwdr_intermediate_certificate = OpenSSL::X509::Certificate.new(File.read("<%= wwdr_certificate_path %>"))
  package.p12 = OpenSSL::PKCS12::new(File.read("<%= key_path %>"), "<%= cert_password %>")
end
