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
end
