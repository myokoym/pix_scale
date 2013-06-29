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

  def test_scale_and_save
    path = "test/fixtures/nijip.png"
    scaled_path = "test/fixtures/nijip-0.5.png"
    File.delete(scaled_path) if File.exist?(scaled_path)
    pic = PixScale::Pic.new(path)
    pic.scale_and_save(0.5)
    assert_true(File.file?(scaled_path))
    assert_true(File.size(path) > File.size(scaled_path))
    assert_true(File.size(scaled_path) > 0)
    File.delete(scaled_path)
  end

  def test_scale
    path = "test/fixtures/nijip.png"
    scale = 0.5
    pic = PixScale::Pic.new(path)
    before_pic = pic.instance_variable_get(:@pic).dup
    after_pic = pic.scale(scale).instance_variable_get(:@pic).dup
    assert_equal(before_pic.width * scale, after_pic.width)
    assert_equal(before_pic.height * scale, after_pic.height)
  end

  def test_scale_abs
    path = "test/fixtures/nijip.png"
    width = 240
    height = 180
    pic = PixScale::Pic.new(path)
    scaled_pic = pic.scale("#{width},#{height}").instance_variable_get(:@pic)
    assert_equal(width, scaled_pic.width)
    assert_equal(height, scaled_pic.height)
  end
end
