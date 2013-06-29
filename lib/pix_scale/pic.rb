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
      @type = (/\A\.jpg\z/i =~ extname) ? "jpeg" : extname.sub(/^\./, "").downcase
    end

    def scale_and_save(scale)
      output_path = "#{dirname}/#{basename}-#{scale.to_s}#{extname}"
      scale(scale).save(output_path)
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

    def save(output_path)
      @pic.save(output_path, @type)
    end

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
