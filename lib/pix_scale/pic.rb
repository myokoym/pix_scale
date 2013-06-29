require "gdk_pixbuf2"

module PixScale
  class Pic
    def self.scale_and_save(path, scale)
      new(path).scale_and_save(scale)
    end

    attr_reader :path, :type
    def initialize(path)
      @path = path
      @pic = Gdk::Pixbuf.new(path)
      @type = (/\A\.jpg\z/ =~ extname) ? "jpeg" : extname.sub(/^\./, "")
    end

    def scale_and_save(scale)
      scaled_pic = @pic.scale(@pic.width * scale, @pic.height * scale)

      output_path = "#{dirname}/#{basename}-#{scale.to_s}#{extname}"
      scaled_pic.save(output_path, type)
    end

    def dirname
      File.dirname(path)
    end

    def basename
      File.basename(path, ".*")
    end

    def extname
      File.extname(path)
    end
  end
end
