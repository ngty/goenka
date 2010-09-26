require File.join(File.dirname(__FILE__),'example_helper')

describe "Album to Requests" do

  before do
    Goenka.config_file = data('goenka/config2.yml')
    Goenka.configure
  end

  it 'should translate all files to requests (reflecting selected profile)' do
    album('awesome', %w{/pics/x1.jpg /pics/x2.jpg}).to_requests.should == [
      {
        :photo => '/pics/x1.jpg', :tags => 'awesome', :is_family => '9',
        :is_public => '9', :is_friend => '9', :safety_level => '9',
        :hidden => '9', :content_type => '9', :title => '', :description => ''
      }, {
        :photo => '/pics/x2.jpg', :tags => 'awesome', :is_family => '9',
        :is_public => '9', :is_friend => '9', :safety_level => '9',
        :hidden => '9', :content_type => '9', :title => '', :description => ''
      }
    ]
  end

  it 'should raise Goenka::UploadProfileNotFoundError if upload profile is missing' do
    Goenka.config_file = data('goenka/configX.yml')
    Goenka.configure
    lambda { album('awesome', %w{/pics/x1.jpg /pics/x2.jpg}).to_requests }.
      should raise_error(
        Goenka::UploadProfileNotFoundError,
        'Cannot find upload profile %s !!' %
          File.join(File.dirname(Goenka.config_file), 'upload_profiles', 'missing.yml')
      )
  end

end
