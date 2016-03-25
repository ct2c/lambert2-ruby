

class Lambert2RubyTest < Test::Unit::TestCase
  require "lambert2_ruby"

  def test_lambert_proj
    result = Lambert2Ruby::lambert_proj(45.7156058, 4.85958679999999)

    assert_equal [844649.3015913883, 6514595.073166063], result
  end
end
