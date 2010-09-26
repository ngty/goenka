require 'nokogiri'
require 'yaml'
require 'curb'

require 'goenka/configurable'
require 'goenka/selectable'
require 'goenka/hacks'
require 'goenka/album'

module Goenka

  extend Configurable
  extend Selectable

  configure

end

