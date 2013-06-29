require "pix_scale/pic"

class PicTest < Test::Unit::TestCase
  def test_static_scale_and_save
    path = "test/fixtures/nijip.png"
    scaled_path = "test/fixtures/nijip-0.5.png"
    File.delete(scaled_path) if File.exist?(scaled_path)
    PixScale::Pic.scale_and_save(path, 0.5)
    assert_true(File.file?(scaled_path))
    assert_true(File.size(path) > File.size(scaled_path))
    assert_true(File.size(scaled_path) > 0)
    File.delete(scaled_path)
  end

  class ScaleAndSaveTest < self
    def test_scale_and_save
      path = "test/fixtures/nijip.png"
      scale = 0.5
      scaled_path = "test/fixtures/nijip-0.5.png"
      File.delete(scaled_path) if File.exist?(scaled_path)
      pic = PixScale::Pic.new(path)
      pic.scale_and_save(scale)
      assert_true(File.file?(scaled_path))
      assert_true(File.size(path) > File.size(scaled_path))
      assert_true(File.size(scaled_path) > 0)
      File.delete(scaled_path)
    end

    def test_scale_and_save_upcase_PNG
      path = "test/fixtures/nyanko.PNG"
      scale = 0.66
      scaled_path = "test/fixtures/nyanko-0.66.PNG"
      File.delete(scaled_path) if File.exist?(scaled_path)
      pic = PixScale::Pic.new(path)
      pic.scale_and_save(scale)
      assert_true(File.file?(scaled_path))
      assert_true(File.size(path) > File.size(scaled_path))
      assert_true(File.size(scaled_path) > 0)
      File.delete(scaled_path)
    end

    def test_scale_and_save_upcase_JPG
      path = "test/fixtures/teabreak.JPG"
      scale = 0.09
      scaled_path = "test/fixtures/teabreak-0.09.JPG"
      File.delete(scaled_path) if File.exist?(scaled_path)
      pic = PixScale::Pic.new(path)
      pic.scale_and_save(scale)
      assert_true(File.file?(scaled_path))
      assert_true(File.size(path) > File.size(scaled_path))
      assert_true(File.size(scaled_path) > 0)
      File.delete(scaled_path)
    end
  end

  class ScaleTest < self
    def setup
      @path = "test/fixtures/nijip.png"
      @pic = PixScale::Pic.new(@path)
      @before_pic = @pic.instance_variable_get(:@pic).dup
    end

    def test_float
      scale = 0.5
      scaled_pic = @pic.scale(scale).instance_variable_get(:@pic)
      assert_equal(@before_pic.width * scale, scaled_pic.width)
      assert_equal(@before_pic.height * scale, scaled_pic.height)
    end

    def test_string_like_float
      scale = "0.5"
      scaled_pic = @pic.scale(scale).instance_variable_get(:@pic)
      assert_equal(@before_pic.width * scale.to_f, scaled_pic.width)
      assert_equal(@before_pic.height * scale.to_f, scaled_pic.height)
    end

    def test_integer_as_width
      width = 240
      scaled_pic = @pic.scale(width).instance_variable_get(:@pic)
      assert_equal(width, scaled_pic.width)
      assert_equal(@before_pic.height * (width.to_f / @before_pic.width), scaled_pic.height)
    end

    def test_string_as_width
      width = "240"
      scaled_pic = @pic.scale(width).instance_variable_get(:@pic)
      assert_equal(width.to_i, scaled_pic.width)
      assert_equal(@before_pic.height * (width.to_f / @before_pic.width), scaled_pic.height)
    end

    def test_string_as_height
      height = "180"
      scaled_pic = @pic.scale(",#{height}").instance_variable_get(:@pic)
      assert_equal(@before_pic.width * (height.to_f / @before_pic.height), scaled_pic.width)
      assert_equal(height.to_i, scaled_pic.height)
    end

    def test_string_width_and_height
      width = 240
      height = 180
      scaled_pic = @pic.scale("#{width},#{height}").instance_variable_get(:@pic)
      assert_equal(width, scaled_pic.width)
      assert_equal(height, scaled_pic.height)
    end
  end
end
