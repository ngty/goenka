module Goenka

  class ConfigFileNotFoundError < Exception ; end
  class UploadProfileNotFoundError < Exception ; end

  module Configurable

    DEFAULTS = {
      :config_file => File.join(ENV['HOME'], '.goenka', 'config.yml'),
      :picasa_albums_dir => File.join(
        ENV['HOME'], '.google/picasa/3.0/drive_c/Documents\ and\ Settings', ENV['USER'],
        'Local\ Settings/Application\ Data/Google/Picasa2Albums'
      ),
      :upload_profile => nil,
      :flickr_api_key => nil,
      :flickr_shared_secret => nil
    }

    attr_accessor *DEFAULTS.keys

    def configure
      begin
        # Preliminary config bypasses config file
        opts = DEFAULTS.dup
        if config_file
          opts.delete(:config_file)
          opts.update(yaml_to_config(config_file))
        end
        opts.each{|key, val| Goenka.send(:"#{key}=", val) }
      rescue Errno::ENOENT
        raise ConfigFileNotFoundError.new("Cannot find config file #{config_file} !!")
      end
    end

    def yaml_to_config(file)
      YAML.load_file(file).inject({}) do |memo,(k,v)|
        memo.merge(k.to_sym => v.to_s)
      end
    end

    def upload_profile_config
      file = File.join(File.dirname(config_file), 'upload_profiles', "#{upload_profile}.yml")
      begin
        yaml_to_config(file)
      rescue Errno::ENOENT
        # It is OK to have missing upload profile, only if user has not attempted
        # to explicitely specify any (meaning upload_profile remains nil)
        return {} unless upload_profile
        raise UploadProfileNotFoundError.new("Cannot find upload profile #{file} !!")
      end
    end

  end

end
