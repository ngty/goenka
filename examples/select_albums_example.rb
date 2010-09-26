require File.join(File.dirname(__FILE__),'example_helper')

describe "Selecting Albums" do

  before do
    Goenka.config_file = data('goenka.yml')
    Goenka.configure
  end

  it "should raise Goenka::AlbumNotFoundError if cannot find matching album" do
    album = 'superduper'
    lambda { Goenka.select(album) }.should raise_error(
      Goenka::AlbumNotFoundError,
      "Cannot find album '#{album}' !!"
    )
  end

  it "should return matching album if there is one" do
    album = 'awesome'
    Goenka.select(album).should ==
      album(album, (1..3).map{|i| home("pics/x#{i}.jpg") })
  end

  it "should return all albums if given :all" do
    Goenka.select(:all).should == [
      album('awesome', (1..3).map{|i| home("pics/x#{i}.jpg") }),
      album('wonderful', (1..3).map{|i| home("pics/y#{i}.jpg") })
    ]
  end

end
