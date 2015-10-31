require "pigeon_band/version"

module PigeonBand
  def self.format(band, country = "DV")
    band.upcase!
    band.tr!('. /', '---')
    band = country + '-' + band unless band.match(/^[A-Z]/)
    list = band.split('-')
    case list[0]
      when 'B'
        year = checked_year(band, list[1])
        sequ = list[2].to_i
        band = sprintf("B-%02d-%07d", year % 100, sequ)
        slug = band
      when 'DV'
        club = list[1].to_i
        year = checked_year(band, list[2])
        sequ = list[3].to_i
        band = sprintf("DV-0%d-%02d-%d", club, year % 100, sequ)
        slug = sprintf("DV-%05d-%02d-%04d", club, year % 100, sequ)
      when 'NL'
        year = list[1].to_i
        sequ = list[2].to_i
        band = sprintf("NL-%02d-%07d", year % 100, sequ)
        slug = band
      else
        raise "Please add more formats at https://github.com/volkerwiegand/pigeon_band"
    end
    [band, slug, year]
  end

private

  def formatted_year(band, year)
    msg = "invalid year '#{year}' in pigeon band '#{band}'"
    raise msg unless year.match(/^\d/)
    return 2000 + year if year in  0..59
    return 1900 + year if year in 60..99
    raise msg
  end
end

# vim: set et ts=2 sw=2 ai:
