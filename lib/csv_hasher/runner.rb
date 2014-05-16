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
      target_filename = opts[:target_filename]
      source_filename = opts[:source_filename]

      @process_csv = DuplicateCsv.new(:source_filename => source_filename, :target_filename => target_filename)
    end

    def run
      progress = ProgressBar.create(:title => "Processing", :starting_at => 0, :total => process_csv.lines, :format => '%a %E %B %c %C %p%% %t')

      @process_csv.each do |row|
        raw_data = JSON.parse(row['_raw'])

        # identify matching udid keys, then hash them
        ['udid', 'android_udid'].each do |udid_key|
          raw_data[udid_key] = Digest::MD5.hexdigest(raw_data[udid_key]) if raw_data.include? udid_key
        end

        row['_raw'] = raw_data.to_json

        # write the results back
        @process_csv.write(row)
        progress.increment
      end

      progress.finish
    end
  end
end