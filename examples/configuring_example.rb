require File.join(File.dirname(__FILE__),'example_helper')

describe "Configuring" do

  it "should raise ConfigFileNotFoundError if cannot find config file" do
    Goenka.config_file = config_file = '/missing/file'
    lambda { Goenka.configure }.should raise_error(
      Goenka::ConfigFileNotFoundError,
      'Cannot find config file %s !!' % config_file
    )
  end

  it "should have config file settings should override defaults" do
    Goenka.config_file = config_file = data('goenka/config.yml')
    custom = YAML.load_file(config_file)
    Goenka.configure
    Goenka.picasa_albums_dir = custom[:picasa_albums_dir]
    Goenka.flickr_api_key = custom[:flickr_api_key]
    Goenka.flickr_shared_secret = custom[:flickr_shared_secret]
  end

end
