require "lambert"

class LambertTest < Test::Unit::TestCase
  def test_lambert_proj
    result = lambert_proj(45.7156058, 4.85958679999999)

    assert_equal [844649.3015913883, 6514595.073166063], result
  end
end
