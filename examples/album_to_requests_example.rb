require File.join(File.dirname(__FILE__),'example_helper')

describe "Album to Requests" do

  it 'should translate all files to requests' do
    album('awesome', %w{/pics/x1.jpg /pics/x2.jpg}).to_requests.should == [
      {
        :photo => '/pics/x1.jpg', :tags => 'awesome', :is_family => '1',
        :is_public => '0', :is_friend => '0', :safety_level => '1',
        :hidden => '1', :content_type => '1', :title => '', :description => ''
      }, {
        :photo => '/pics/x2.jpg', :tags => 'awesome', :is_family => '1',
        :is_public => '0', :is_friend => '0', :safety_level => '1',
        :hidden => '1', :content_type => '1', :title => '', :description => ''
      }
    ]
  end

end
