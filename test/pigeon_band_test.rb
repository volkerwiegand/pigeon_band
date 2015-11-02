require 'test_helper'

class PigeonBandTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PigeonBand::VERSION
  end

  def test_that_it_has_a_default_country
    refute_nil ::PigeonBand::COUNTRY
  end

  def test_that_the_homepage_is_defined
    refute_nil ::PigeonBand::HOMEPAGE
  end

  def test_that_it_refuses_nil_input
    hash = PigeonBand.format("")
    assert_equal "input_missing", hash[:error]
  end

  def test_that_it_refuses_blank_input
    hash = PigeonBand.format("")
    assert_equal "input_missing", hash[:error]
  end

  def test_that_it_refuses_space_input
    hash = PigeonBand.format("  ")
    assert_equal "input_missing", hash[:error]
  end

  def test_that_it_refuses_invalid_country
    hash = PigeonBand.format("XX-1")
    assert_equal "country_unknown", hash[:error]
  end

  # Caution: the following tests assume DV as default country
  def test_that_it_adds_the_default_country
    hash = PigeonBand.format("1-1-1")
    assert_equal "DE", hash[:code]
  end

  def test_that_it_keeps_the_country
    hash = PigeonBand.format("B-1-1000001")
    assert_equal "BE", hash[:code]
  end
end

# vim: set et ts=2 sw=2 ai:
