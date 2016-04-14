class Lambert93RubyTest < Test::Unit::TestCase
  require  "lambert93_ruby"

  def test_lambert_proj
    arveyres = Lambert93Ruby::lambert_proj(45.7156058, 4.85958679999999)
    assert_equal [844649.3015913883, 6514595.073166063], arveyres

    pusignan = Lambert93Ruby::lambert_proj(45.757652, 5.0701733)
    assert_equal [860903.96, 6519670.35], pusignan.map{|i| i.round(2)}

    ## Ile de France
    beaumont_sur_oise = Lambert93Ruby::lambert_proj(49.1415510, 2.2846010 )
    assert_equal [647796.31706025,  6893766.105254374], beaumont_sur_oise

    chateau_landon = Lambert93Ruby::lambert_proj(48.150232, 2.7044260)
    assert_equal [678018.7566706568, 6783359.741741321], chateau_landon

    provins = Lambert93Ruby::lambert_proj( 48.5601490, 3.2992030)
    assert_equal [722078.4810329215, 6828922.492311118], provins

    rambouillet = Lambert93Ruby::lambert_proj(48.6438680, 1.8290789)
    assert_equal [613737.5587523837, 6838827.35755566], rambouillet

    calais = Lambert93Ruby::lambert_proj(50.95129000000001, 1.8586860000000343)
    assert_equal [619630.8725958228, 7095614.832194619], calais

    nice = Lambert93Ruby::lambert_proj(43.7101728, 7.261953199999994)
    assert_equal [1043406.5555545087,  6299396.821049856], nice

    andorre = Lambert93Ruby::lambert_proj( 42.506285, 1.5218009999999822)
    assert_equal [578337.7238319971, 6157413.046731045], andorre
  end
end
