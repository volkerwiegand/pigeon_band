require "pigeon_band/version"

module PigeonBand
  def self.format(band, country = "DV")
    band.upcase!
    band.tr!('. /', '---')
    band = country + '-' + band unless band.match(/^[A-Z]/)
    list = band.split('-')
    case list[0]
      when 'B'
        year = list[1].to_i
        sequ = list[2].to_i
        band = sprintf("B-%02d-%07d", year % 100, sequ)
        slug = band
      when 'DV'
        club = list[1].to_i
        year = list[2].to_i
        sequ = list[3].to_i
        band = sprintf("DV-0%d-%02d-%d", club, year % 100, sequ)
        slug = sprintf("DV-%05d-%02d-%04d", club, year % 100, sequ)
      when 'NL'
        year = list[1].to_i
        sequ = list[2].to_i
        band = sprintf("NL-%02d-%07d", year % 100, sequ)
        slug = band
      else
        raise "Please add more formats on https://github.com/volkerwiegand/pigeon_band"
    end
    [band, slug, year]
  end
end

# vim: set et ts=2 sw=2 ai:
