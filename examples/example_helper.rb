require 'rubygems'
require 'micronaut'

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'goenka'

def not_in_editor?
  !(ENV.has_key?('TM_MODE') || ENV.has_key?('EMACS') || ENV.has_key?('VIM'))
end

Micronaut.configure do |c|
  c.color_enabled = not_in_editor?
  c.filter_run :focused => true
end

def data(*args)
  File.join(File.dirname(__FILE__), 'data', *args)
end

def home(*args)
  File.join(ENV['HOME'], *args)
end

def album(*args)
  Goenka::Album.new(*args)
end

def requests(*args)
  args.map do |h|
    h.map do |(k,v)|
      meth = k == :photo ? :file : :content
      Curl::PostField.send(meth, k, v)
    end.sort_by(&:name)
  end
end

class Curl::PostField
  def ==(other)
    to_s == other.to_s
  end
end
