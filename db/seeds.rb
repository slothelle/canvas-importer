class ChattySeeder
  include Importer
  include Sorter

  def initialize
    print "\nImport processing..."
    # Reading all CSV files from db/csv folder
    # Creating Student, Course objects
    load_all_csv_files { |file| parse_csv(file) }
    # Creating Enrollment objects
    create_enrollments
  end

  def display_results
    students = Student.count
    courses = Course.count
    enrollments = Enrollment.count
    puts "\nImport complete!"
    puts "Total entries: #{(students + courses + enrollments)}"
    puts "Total students: #{students}"
    puts "Total courses: #{courses}"
    puts "Total enrollments: #{enrollments}"
  end
end

seed = ChattySeeder.new
seed.display_results