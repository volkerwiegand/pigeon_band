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
Given a band as a string, it returns a hash consisting of five fields.

Please note that the input is normalized before being scanned. Any '/' (slash), '.' (dot),
'-' (dash) or ' ' (space) is converted to a '-' (dash). If the input does nor start with a letter
a default of DV is added. Alternatively, a second argument can be added to calling #format.

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

Given the above bands a input, a call to PigeonBand#format would return the following hashes:

```ruby
PigeonBand.format("DV-06914-12-479")
  { band: "DV-06914-12-479", coll: "DV-06914-12-0479", year: 2012, code: "DE", error: nil }

PigeonBand.format("DV-099-09-850")
  { band: "DV-099-09-850", coll: "DV-00099-09-0850", year: 2009, code: "DE", error: nil }

PigeonBand.format("B-08-2148152")
  { band: "B-08-2148152", coll: "B-08-2148152", year: 2008, code: "BE", error: nil }

PigeonBand.format("8.2148152", "B")
  { band: "B-08-2148152", coll: "B-08-2148152", year: 2008, code: "BE", error: nil }

PigeonBand.format("1 1 1")
  { band: "DV-01-01-1", coll: "DV-00001-01-0001", year: 201, code: "DE", error: nil }

PigeonBand.format("")
  { band: nil, coll: nil, year: nil, code: nil, error: "input_missing" }

PigeonBand.format("XX-1")
  { band: nil, coll: nil, year: nil, code: nil, error: "country_unknown" }
```

## Error messages

The following error messages are sent when the corresponding error is detected:

* input_missing
    * The input is blank or consists entirely of white space.

* country_unknown
    * The given country was not recognized.
    * You can help improving this gem by contributing it :-)
    * See below for details.

* year_missing
    * The year is missing for this country.

* year_invalid
    * The year is invalid (i.e. not a number).

* year_range
    * The given year is outside the valid range of 0 to 99.

* club_below
    * The given club (for countries with club numbers) is too low.

* club_above
    * The given club (for countries with club numbers) is too high.

* sequ_below
    * The given running number is too low.

* sequ_above
    * The given running number is too high.

## Complete Rails example

TODO: show model, controller, view, route and locale data

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/volkerwiegand/pigeon_band.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

