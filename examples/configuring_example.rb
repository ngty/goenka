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
    Goenka.config_file = config_file = data('goenka.yml')
    custom = YAML.load_file(config_file)
    Goenka.configure
    Goenka.picasa_albums_dir = custom[:picasa_albums_dir]
    Goenka.flickr_id = custom[:flickr_id]
    Goenka.flickr_password = custom[:flickr_password]
  end

end
