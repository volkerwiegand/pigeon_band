require "pigeon_band/version"

module PigeonBand
  def self.format(band, country = COUNTRY)
    raise "missing input for pigeon band" if band.nil? or band == ""
    band_msg = "in pigeon band '#{band}'"
    band.upcase!
    band.tr!('. /', '---')
    band = country + '-' + band unless band.match(/^[A-Z]/)
    list = band.split('-')
    case list[0]
      when 'B'
        year = get_year(band, list[1], band_msg)
        sequ = get_number(band, list[2], "counter", 1, 9999999, band_msg)
        band = sprintf("B-%02d-%07d", year % 100, sequ)
        slug = band
        code = 'BE'
      when 'DV'
        club = get_number(band, list[1], "club", 1, 9999, band_msg)
        year = get_year(band, list[2], band_msg)
        sequ = get_number(band, list[3], "counter", 1, 9999, band_msg)
        band = sprintf("DV-0%d-%02d-%d", club, year % 100, sequ)
        slug = sprintf("DV-%05d-%02d-%04d", club, year % 100, sequ)
        code = 'DE'
      when 'NL'
        year = get_year(band, list[1], band_msg)
        sequ = get_number(band, list[2], "counter", 1, 9999999, band_msg)
        band = sprintf("NL-%02d-%07d", year % 100, sequ)
        slug = band
        code = 'NL'
      else
        raise "Please add more formats at https://github.com/volkerwiegand/pigeon_band"
    end
    { band: band, slug: slug, year: year, code: code }
  end

private

  def self.get_year(band, year, band_msg)
    raise "missing year #{band_msg}" if year.nil? or year == ""
    raise "invalid year '#{year}' #{band_msg}" unless year.match(/^\d/)
    year = year.to_i
    raise "year '#{year}' out of range #{band_msg}" if year < 0 or year > 99
    year += 2000
    year -= 100 if year > (Time.now.to_date.year + 5)
    return year
  end

  def self.get_number(band, num, num_type, min_num, max_num, band_msg)
    raise "missing #{num_type} #{band_msg}" if num.nil? or num == ""
    raise "invalid #{num_type} '#{num}' #{band_msg}" unless num.match(/^\d/)
    num = num.to_i
    raise "#{num_type} '#{num}' too small #{band_msg}" if num < min_num
    raise "#{num_type} '#{num}' too big #{band_msg}"   if num > max_num
    return num
  end
end

# vim: set et ts=2 sw=2 ai:
