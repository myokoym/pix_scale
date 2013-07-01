# TODO: Remove me. It is workaround untill Ruby/GdkPixbuf2 2.0.3 is released.
# This is required in order to work on Windows.
require "cairo"

require "gdk_pixbuf2"

module PixScale
  class Pic
    def self.scale_and_save(path, scale, type=nil)
      new(path).scale_and_save(scale, type)
    end

    attr_reader :path, :type
    def initialize(path)
      @path = path
      @pic = Gdk::Pixbuf.new(path)
      @type = (/\A\.jpg\z/i =~ extname) ? "jpeg" : extname.sub(/^\./, "").downcase
    end

    def scale_and_save(scale, type=nil)
      scale_string = scale.to_s.sub(/[^\.0-9]/, "_")
      extention = type || extname
      extention = ".#{extention}" unless /\A\./ =~ extention
      output_path = "#{dirname}/#{basename}-#{scale_string}#{extention}"
      scale(scale).save(output_path, type)
    end

    def scale(scale)
      new_pic = self.dup
      new_pic.scale!(scale)
      new_pic
    end

    def scale!(scale)
      if scale.is_a?(Float)
        width = @pic.width * scale
        height = @pic.height * scale
      elsif scale.is_a?(Integer)
        width = scale
        height = @pic.height * (scale.to_f / @pic.width)
      elsif /\A[0-9]+\.[0-9]+\z/ =~ scale
        width = @pic.width * scale.to_f
        height = @pic.height * scale.to_f
      elsif /\A[0-9]+[^\.0-9][0-9]+\z/ =~ scale
        width, height = scale.split(/[^\.0-9]/).map(&:to_i)
      elsif /\A[0-9]+\z/ =~ scale
        width = scale.to_i
        height = @pic.height * (scale.to_f / @pic.width)
      elsif /\A[^\.0-9]([0-9]+)\z/ =~ scale
        width = @pic.width * ($1.to_f / @pic.height)
        height = $1.to_i
      end

      @pic = @pic.scale(width, height)
    end

    def save(output_path, type=nil)
      output_type = type || @type
      @pic.save(output_path, output_type)
    end

    private
    def dirname
      File.dirname(@path)
    end

    def basename
      File.basename(@path, ".*")
    end

    def extname
      File.extname(@path)
    end
  end
end
