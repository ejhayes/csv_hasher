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
    require 'trollop'

    opts = Trollop::options do
      banner <<-EOS
    Outputs a CSV file with a specified column replaced with a corresponding hash.
    EOS
      opt :log, "output to logfile (default is STDOUT)", :type => :io, :default => STDOUT
      opt :debug, "enable debugging mode"
      opt :file, "csv file to process", :type => :io, :required => true
      opt :target_key_regex, "regex for keys that need to be hashed", :type => :string, :required => true
      opt :target_column, "column containing the json data", :type => :string, :required => true
      opt :output_to, "output results file", :type => :string, :default => "hashed_results.csv"
      opt :hash_with, "hashing algorithm to use", :type => :string, :default => 'MD5'
    end

    # Must be a valid hash type
    valid_hashing_types = %w(MD5)
    Trollop::die :hash_with, "must be a valid hashing type" unless valid_hashing_types.include? opts[:hash_with]

    runner = CsvHasher::Runner.new(opts)

    runner.run
    

### Or the executable

    bundle exec bin/csv_hasher --file test_data.csv --target-key-regex ".*ohyes.*" --target-column "_raw" --hash-with "MD5"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
