require 'digest/sha1'
require 'json'
require 'openssl'
require 'zip/zip'
require 'zip/zipfilesystem'

module WebNotification

  class NotificationPackage
    include Singleton

    attr_accessor :files, :json, :wwdr_intermediate_certificate_path, :cert_path, :wwdr_intermediate_certificate, :p12

    def configure
      yield self
    end

    def generate_with_auth_token(authentication_token)
      files = {}
      path = "notification/web_package"
      Dir.glob(path+"/**/**").each do |file_path|
        next if File.directory? file_path
        filename = Pathname.new(file_path).relative_path_from(Pathname.new(path))
        file = File.open(file_path, "rb")
        files[filename.to_s] = File.read(file)
      end

      json = JSON.parse(files['website.json'])
      json['authenticationToken'] = authentication_token
      files['website.json'] = JSON.pretty_generate(json)

      manifest = {}
      files.each do |filename, content|
        manifest[filename] = Digest::SHA1.hexdigest(content)
      end
      files['manifest.json'] = JSON.pretty_generate(manifest)
      

      flag = OpenSSL::PKCS7::BINARY|OpenSSL::PKCS7::DETACHED
      signed = OpenSSL::PKCS7::sign(p12.certificate, p12.key, files['manifest.json'], [wwdr_intermediate_certificate], flag)
      files['signature'] = signed.to_der.force_encoding('UTF-8')


      stringio = Zip::ZipOutputStream::write_buffer do |z|
        files.each do |filename, content|
          z.put_next_entry filename
          z.print content
        end
      end
      stringio.set_encoding "binary"
      stringio.rewind
      stringio
    end
  end
end