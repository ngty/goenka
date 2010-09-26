module Goenka
  class Album < Struct.new(:name, :files)

    PER_FILE_DEFAULTS = {
      :is_family => '1',
      :is_public => '0',
      :is_friend => '0',
      :safety_level => '1',
      :hidden => '1',
      :content_type => '1',
      :title => '',
      :description => ''
    }

    def to_requests
      files.map do |file|
        per_file_defaults.merge(:photo => file)
      end
    end

    def per_file_defaults
      @per_file_defaults ||=
        PER_FILE_DEFAULTS.merge(:tags => name).merge(Goenka.upload_profile_config)
    end

  end
end
