require "pigeon_band/version"

module PigeonBand
  def self.format(band, country = COUNTRY)
    return { error: "input_missing" } if band.nil? or band.match(/\A[[:space:]]*\z/)
    band.upcase!
    band.tr!('. /', '---')
    band = country + '-' + band unless band.match(/^[A-Z]/)
    list = band.split('-')
    case list[0]
      when 'B'
        year = get_year(band, list[1])
        return year if year.is_a?(Hash)
        sequ = get_number(band, list[2], "sequ", 1000001, 9999999)
        return sequ if sequ.is_a?(Hash)
        band = sprintf("B-%02d-%07d", year % 100, sequ)
        coll = band
        code = 'BE'
      when 'DV'
        club = get_number(band, list[1], "club", 1, 9999)
        return club if club.is_a?(Hash)
        year = get_year(band, list[2])
        return year if year.is_a?(Hash)
        sequ = get_number(band, list[3], "sequ", 1, 9999)
        return sequ if sequ.is_a?(Hash)
        band = sprintf("DV-0%d-%02d-%d", club, year % 100, sequ)
        coll = sprintf("DV-%05d-%02d-%04d", club, year % 100, sequ)
        code = 'DE'
      when 'NL'
        year = get_year(band, list[1])
        return year if year.is_a?(Hash)
        sequ = get_number(band, list[2], "sequ", 1000001, 9999999)
        return sequ if sequ.is_a?(Hash)
        band = sprintf("NL-%02d-%07d", year % 100, sequ)
        coll = band
        code = 'NL'
      else
        return { error: "country_unknown" }
    end
    { band: band, coll: coll, year: year, code: code, error: nil }
  end

private

  def self.get_number(band, num, num_type, min_num, max_num)
    return { error: "#{num_type}_missing" } if num.nil? or num.empty?
    return { error: "#{num_type}_invalid" } unless num.match(/^\d/)
    num = num.to_i
    return { error: "#{num_type}_below" } if num < min_num
    return { error: "#{num_type}_above" } if num > max_num
    return num
  end

  def self.get_year(band, year)
    return { error: "year_missing" } if year.nil? or year.empty?
    return { error: "year_invalid" } unless year.match(/^\d/)
    year = year.to_i
    return { error: "year_range" } if year < 0 or year > 99
    year += 2000
    year -= 100 if year > (Time.now.to_date.year + 5)
    return year
  end
end

# vim: set et ts=2 sw=2 ai:
