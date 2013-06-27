require "gdk_pixbuf2"
require "pix_scale/version"

module PixScale
  class Command
    def self.run(*arguments)
      if /\A(-h|--help)\z/ =~ arguments[0]
        puts <<-EOM
Usage:   pix_scale FILE... SCALE
Example: pix_scale foo.png 0.5
        EOM
        exit(true)
      elsif /\A(-v|--version)\z/ =~ arguments[0]
        puts PixScale::VERSION
        exit(true)
      end

      scale = arguments.pop.to_f

      arguments.each do |pic_path|
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
end
