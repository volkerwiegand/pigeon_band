require "pigeon_band/version"

module PigeonBand
  def self.format(band, country = "DV")
    ["#{country}-#{band}", 2015]
  end
end

# vim: set et ts=2 sw=2 ai:
