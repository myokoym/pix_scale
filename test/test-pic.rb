require "pix_scale/pic"

class PicTest < Test::Unit::TestCase
  def test_scale_and_save
    path = "test/fixtures/nijip.png"
    scaled_path = "test/fixtures/nijip-0.5.png"
    PixScale::Pic.scale_and_save(path, 0.5)
    assert_true(File.file?(scaled_path))
    assert_true(File.size(path) > File.size(scaled_path))
    assert_true(File.size(scaled_path) > 0)
    File.delete(scaled_path)
  end
end
