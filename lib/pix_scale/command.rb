require "pix_scale/pic"
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

      scale = arguments.pop

      arguments.each do |pic_path|
        Pic.scale_and_save(pic_path, scale)
      end
    end
  end
end
