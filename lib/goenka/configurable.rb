module Goenka

  class ConfigFileNotFoundError < Exception ; end

  module Configurable

    DEFAULTS = {
      :config_file => File.join(ENV['HOME'], '.goenka.yml'),
      :picasa_albums_dir => File.join(
        ENV['HOME'], '.google/picasa/3.0/drive_c/Documents\ and\ Settings', ENV['USER'],
        'Local\ Settings/Application\ Data/Google/Picasa2Albums'
      ),
      :flickr_api_key => nil,
      :flickr_shared_secret => nil
    }

    attr_accessor *DEFAULTS.keys

    def configure
      begin
        # Preliminary config bypasses config file
        opts = DEFAULTS
        opts.update(YAML.load_file(config_file)) if config_file
        opts.each{|key, val| Goenka.send(:"#{key}=", val) }
      rescue Errno::ENOENT
        raise ConfigFileNotFoundError.new("Cannot find config file #{config_file} !!")
      end
    end

  end

end
