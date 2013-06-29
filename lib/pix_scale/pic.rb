require "gdk_pixbuf2"

module PixScale
  class Pic
    def self.scale_and_save(path, scale)
      new(path).scale_and_save(scale)
    end

    attr_reader :path, :dirname, :basename, :extname, :pic
    def initialize(path)
      @path = path
      @dirname  = File.dirname(path)
      @basename = File.basename(path, ".*")
      @extname  = File.extname(path).sub(/^\./, "")
      @pic = Gdk::Pixbuf.new(path)
    end

    def scale_and_save(scale)
      scaled_pic = pic.scale(pic.width * scale, pic.height * scale)

      output_path = "#{dirname}/#{basename}-#{scale.to_s}.#{extname}"
      type = (/\Ajpg\z/ =~ extname) ? "jpeg" : extname
      scaled_pic.save(output_path, type)
    end
  end
end
