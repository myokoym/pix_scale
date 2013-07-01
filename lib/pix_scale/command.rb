require "pix_scale/pic"
require "pix_scale/version"

module PixScale
  class Command
    def self.run(*arguments)
      if /\A(-h|--help)\z/ =~ arguments[0]
        puts <<-EOM
Usage:    pix_scale [-t TYPE] FILE... SCALE|WIDTH_HEIGHT
Example1: pix_scale foo.png 0.5
Example2: pix_scale foo.png 240_180
Example3: pix_scale -t png foo 0.5
        EOM
        exit(true)
      elsif /\A(-v|--version)\z/ =~ arguments[0]
        puts PixScale::VERSION
        exit(true)
      elsif /\A(-t|--type)\z/ =~ arguments[0]
        # FIXME: Use OptionParser
        type = arguments[1]
        arguments.shift(2)
      end

      scale = arguments.pop

      arguments.each do |pic_path|
        Pic.scale_and_save(pic_path, scale, type)
      end
    end
  end
end
