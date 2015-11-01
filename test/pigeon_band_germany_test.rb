require 'test_helper'

class PigeonBandGermanyTest < Minitest::Test
  def test_that_country_code_is_DE
    hash = PigeonBand.format("DV-1-0-1")
    assert_equal "DE", hash[:code]
  end

  def test_that_dv_year_0_is_correct
    hash = PigeonBand.format("DV-1-0-1")
    assert_equal 2000, hash[:year]
  end

  def test_that_dv_year_00_is_correct
    hash = PigeonBand.format("DV-1-00-1")
    assert_equal 2000, hash[:year]
  end

  def test_that_dv_year_09_is_correct
    hash = PigeonBand.format("DV-1-09-1")
    assert_equal 2009, hash[:year]
  end

  def test_that_dv_year_99_is_correct
    hash = PigeonBand.format("DV-1-99-1")
    assert_equal 1999, hash[:year]
  end

  def test_that_dv_year_100_is_too_big
    exception = assert_raises(RuntimeError) { PigeonBand.format("DV-1-100-1") }
    assert_match /out of range/, exception.message
  end

  def test_that_dv_refuses_club_0
    exception = assert_raises(RuntimeError) { PigeonBand.format("DV-0-0-1") }
    assert_match /too small/, exception.message
  end

  def test_that_dv_refuses_club_10000
    exception = assert_raises(RuntimeError) { PigeonBand.format("DV-10000-0-1") }
    assert_match /too big/, exception.message
  end

  def test_that_dv_refuses_sequ_0
    exception = assert_raises(RuntimeError) { PigeonBand.format("DV-1-0-0") }
    assert_match /too small/, exception.message
  end

  def test_that_dv_refuses_sequ_10000
    exception = assert_raises(RuntimeError) { PigeonBand.format("DV-1-0-10000") }
    assert_match /too big/, exception.message
  end
end
