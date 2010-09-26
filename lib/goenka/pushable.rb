module Goenka

  class FlickrAuthenticateError < Exception; end

  module Pushable #:notest:

    def push(album)
      authenticate!
      select(album).map(&:to_requests).flatten.each do |requests|
        photo = requests.delete(:photo)
        flickr.upload_photo(photo, requests)
      end
    end

    def authenticate!
      FlickRaw.api_key = flickr_api_key
      FlickRaw.shared_secret = flickr_shared_secret

      unless @auth_token && flickr.auth.checkToken(:auth_token => @auth_token)
        frob = flickr.auth.getFrob
        auth_url = FlickRaw.auth_url(:frob => frob, :perms => 'write')

          puts "Open this url in your process to complete the authication process : #{auth_url}"
          puts "Press Enter when you are finished."
          STDIN.getc

        begin
          @auth_token = flickr.auth.getToken(:frob => frob)
          flickr.test.login
        rescue FlickRaw::FailedResponse => e
          @auth_token = nil
          raise FlickrAuthenticateError.new(e.msg)
        end
      end

    end

  end
end
