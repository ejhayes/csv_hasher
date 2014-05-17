module CsvHasher
  class DuplicateCsv
    def initialize(params={})
      @source_filename = params[:source_filename]
      @target_filename = params[:target_filename] || "hashed_#{@source_filename}"

      @lines = CSV.open(@source_filename).readlines.size

      # open up our target csv and write the same headers as we have
      # for hte source target
      CSV.foreach(@source_filename, :headers => true) do |source_csv|
        CSV.open(@target_filename, 'w') do |target_csv|
          target_csv << source_csv.headers
        end
        
        # bail out
        break
      end
    end

    def each
      CSV.foreach(@source_filename, :headers => true) do |row|
        yield row
      end
    end

    def write(row)
      CSV.open(@target_filename, 'a') do |csv|
        csv << row
      end
    end

    def lines
      @lines
    end
  end

  class Runner
    def initialize(opts)
      source_filename = opts[:file]
      target_filename = opts[:output_to]

      @target_key_regex = opts[:target_key_regex]
      @target_column = opts[:target_column]

      # how do we plan to hash stuff?
      if opts[:hash_with] == 'MD5'
        @hashing_strategy = lambda { |args| Digest::MD5.hexdigest(args) }
      else
        raise StandardError.new("Unsupported hashing type used: #{opts[:hash_with]}")
      end

      @process_csv = DuplicateCsv.new(:source_filename => source_filename, :target_filename => target_filename)
    end

    def run
      progress = ProgressBar.create(:title => "Processing", :starting_at => 0, :total => @process_csv.lines, :format => '%a %E %B %c %C %p%% %t')

      @process_csv.each do |row|
        raw_data = JSON.parse(row[@target_column])

        # identify matching udid keys, then hash them
        raw_data.keys.select { |key| key.match(/#{@target_key_regex}/) }.each do |udid_key|
          raw_data[udid_key] = @hashing_strategy.call(raw_data[udid_key]) if raw_data.include? udid_key
        end

        row[@target_column] = raw_data.to_json

        # write the results back
        @process_csv.write(row)
        progress.increment
      end

      progress.finish
    end
  end
end