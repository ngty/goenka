module Goenka

  class AlbumNotFoundError < Exception ; end

  module Selectable

    def select(name)
      case name
      when :all then select_all
      else select_one(name)
      end
    end

    def select_one(name)
      pattern = %r(\<property\s+name="name"\s+type="string"\s+value="#{name}"\/\>)
      picasa_album_files.each do |file|
        album = File.open(file,'r') do |f|
          Album.new(name, files_within(f)) unless f.grep(pattern).empty?
        end
        return album if album
      end
      raise AlbumNotFoundError.new("Cannot find album '#{name}' !!")
    end

    def select_all
      picasa_album_files.map do |file|
        File.open(file,'r') do |f|
          doc = Nokogiri::XML(f)
          name = doc.xpath('//property[@name="name"]/@value').first.to_s
          Album.new(name, files_within(doc))
        end
      end.sort_by(&:name)
    end

    def picasa_album_files
      Dir[File.join(picasa_albums_dir, '*', '*.pal')]
    end

    def files_within(thing)
      unless thing.respond_to?(:xpath)
        thing.rewind # we need to rewind !!
        thing = Nokogiri::XML(thing)
      end
      thing.xpath('//files/filename/text()').map do |s|
        s.to_s.gsub('\\','/').sub('$My Documents', ENV['HOME'])
      end.sort
    end

  end
end
