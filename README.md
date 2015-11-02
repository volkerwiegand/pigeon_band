# PigeonBand

This Ruby gem helps to format and validate racing pigeon bands (a.k.a. rings) from various countries.

Different countries use different schemes for band numbers. In Germany (my home country) the format
is e.g. DV-06914-12-479. It starts with the country code DV (short for "Deutscher Verein").
Then comes the club number with a leading zero, minimum 01 and maximum 09999.
Next is the year (last two digits) when the band was issued. Finally there is a running number of
at most four digits, starting from 1.

In Belgium or the Netherlands, pigeons are given a 7-digit running number besides year and country
designation. Thus, a valid band would be B-08-2148152.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pigeon_band'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pigeon_band

## Usage

After loading the pigeon_band gem, there is a new object PigeonBand with one method #format.
Given a band as a string, it returns a hash consisting of five fields. Thus, given the
above bands a input, a call to PigeonBand#format would return the following hashes:

* band
    * The normalized band as it should be displayed
* coll
    * The band formatted for easy collation (filled e.g. with leading spaces)
* year
    * The (four-digit) year as extracted from the band
* code
    * The (ISO3166-1) country code as extracted from the band
* error
    * The error message if the band is invalid, otherwise nil

```ruby
PigeonBand.format("DV-06914-12-479")
  { band: "DV-06914-12-479" coll: "DV-06914-12-0479" year: 2012 code: "DE"  error: nil }
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/volkerwiegand/pigeon_band.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

