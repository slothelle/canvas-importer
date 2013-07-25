module Importer
  include Sorter

  def load_all_csv_files
    Dir["db/csv/*.csv"].each { |file| yield file }
  end

  def parse_csv(filename)
    print "."
    CSV.foreach(filename, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      # Uses Sorter module sort and create objects
      identify_data_and_create_objects(Hash[row])
    end
  end
end