# CsvHasher

This takes a csv file and replaces a user specified column with a a hash of the same value.

## Installation

Add this line to your application's Gemfile:

    gem 'csv_hasher'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv_hasher

## Usage

You can experiment with this on the console by doing:

    bundle exec rake console

### As a library

    require 'csv_hasher'

### Or the executable

    hash_csv --file <filename> --column UDID --hash-with md5 --output-to /path/to/file.csv

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
