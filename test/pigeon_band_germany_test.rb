require 'test_helper'

class PigeonBandGermanyTest < Minitest::Test
  def test_for_complete_collation
    hash = PigeonBand.format("DV-1-0-1")
    assert_equal 5, hash.size
    assert_nil hash[:error]
    assert_equal "DV-01-00-1", hash[:band]
    assert_equal "DV-00001-00-0001", hash[:coll]
    assert_equal 2000, hash[:year]
    assert_equal "DE", hash[:code]
  end

  def test_that_country_code_is_DE
    hash = PigeonBand.format("DV-1-0-1")
    assert_nil hash[:error]
    assert_equal "DE", hash[:code]
  end

  def test_that_dv_year_0_is_correct
    hash = PigeonBand.format("DV-1-0-1")
    assert_nil hash[:error]
    assert_equal 2000, hash[:year]
  end

  def test_that_dv_year_00_is_correct
    hash = PigeonBand.format("DV-1-00-1")
    assert_nil hash[:error]
    assert_equal 2000, hash[:year]
  end

  def test_that_dv_year_09_is_correct
    hash = PigeonBand.format("DV-1-09-1")
    assert_nil hash[:error]
    assert_equal 2009, hash[:year]
  end

  def test_that_dv_year_99_is_correct
    hash = PigeonBand.format("DV-1-99-1")
    assert_nil hash[:error]
    assert_equal 1999, hash[:year]
  end

  def test_that_dv_year_100_is_too_big
    hash = PigeonBand.format("DV-1-100-1")
    assert_equal "year_range", hash[:error]
  end

  def test_that_dv_refuses_club_0
    hash = PigeonBand.format("DV-0-0-1")
    assert_equal "club_below", hash[:error]
  end

  def test_that_dv_refuses_club_10000
    hash = PigeonBand.format("DV-10000-0-1")
    assert_equal "club_above", hash[:error]
  end

  def test_that_dv_refuses_sequ_0
    hash = PigeonBand.format("DV-1-0-0")
    assert_equal "sequ_below", hash[:error]
  end

  def test_that_dv_refuses_sequ_10000
    hash = PigeonBand.format("DV-1-0-10000")
    assert_equal "sequ_above", hash[:error]
  end
end

# vim: set et ts=2 sw=2 ai:
