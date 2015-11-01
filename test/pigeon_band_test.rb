require 'test_helper'

class PigeonBandGermanyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PigeonBand::VERSION
  end

  def test_that_it_has_a_default_country
    refute_nil ::PigeonBand::COUNTRY
  end

  def test_that_it_refuses_blank_input
    exception = assert_raises(RuntimeError) { PigeonBand.format("") }
    assert_match /missing input/, exception.message
  end

  # Caution: the following tests assume DV as default country
  def test_that_it_adds_default_country
    hash = PigeonBand.format("1-1-1")
    assert_equal "DE", hash[:code]
  end

  def test_that_it_keeps_country
    hash = PigeonBand.format("B-1-1")
    assert_equal "BE", hash[:code]
  end
end
