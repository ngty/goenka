module Goenka

  class FlickrAuthenticateError < Exception; end

  module Pushable #:notest:

    def push(album)
      authenticate!
      select(album).map(&:to_requests).flatten.each do |request|
        photo = request.delete(:photo)
        flickr.upload_photo(photo, request)
      end
    end

    def authenticate!
      FlickRaw.api_key = flickr_api_key
      FlickRaw.shared_secret = flickr_shared_secret

      frob = flickr.auth.getFrob
      auth_url = FlickRaw.auth_url(:frob => frob, :perms => 'write')

      # TODO: use mechanize (if possible) to avoid toggling to browser !!
      puts "Open this url in your process to complete the authication process : #{auth_url}"
      puts "Press Enter when you are finished."
      STDIN.getc

      begin
        flickr.auth.getToken(:frob => frob)
        flickr.test.login
      rescue FlickRaw::FailedResponse => e
        raise FlickrAuthenticateError.new(e.msg)
      end
    end

  end
end
