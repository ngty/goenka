module Goenka
  class Album < Struct.new(:name, :files)

    # TODO: These can probably be stored as profile ?
    DEFAULT_REQUESTS = {
      :is_family => '1',
      :is_public => '0',
      :is_friend => '0',
      :safety_level => '1',
      :hidden => '1',
      :content_type => '1',
      :title => '',
      :description => ''
    }.map do |(k,v)|
      Curl::PostField.content(k, v)
    end

    def to_requests
      files.map do |file|
        (default_requests + [Curl::PostField.file(:photo, file)]).sort_by(&:name)
      end
    end

    def default_requests
      @default_requests ||= (DEFAULT_REQUESTS + [Curl::PostField.content(:tags, name)])
    end

  end
end
