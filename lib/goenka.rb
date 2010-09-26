require 'nokogiri'
require 'yaml'
require 'flickraw-cached'

module Goenka

  class << self
    def require_rb(*args)
      require File.join(File.dirname(__FILE__), 'goenka', *args)
    end
  end

  require_rb 'configurable'
  require_rb 'selectable'
  require_rb 'pushable'
  require_rb 'album'
  require_rb 'hacks'

  extend Configurable
  extend Selectable
  extend Pushable

  configure # preliminary configuration when app inits

end

