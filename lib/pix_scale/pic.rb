require "gdk_pixbuf2"

module PixScale
  class Pic
    def self.scale_and_save(pic_path, scale)
      dirname  = File.dirname(pic_path)
      basename = File.basename(pic_path, ".*")
      extname  = File.extname(pic_path).sub(/^\./, "")

      pic = Gdk::Pixbuf.new(pic_path)
      scaled_pic = pic.scale(pic.width * scale, pic.height * scale)

      output_path = "#{dirname}/#{basename}-#{scale.to_s}.#{extname}"
      type = (/\Ajpg\z/ =~ extname) ? "jpeg" : extname
      scaled_pic.save(output_path, type)
    end
  end
end
