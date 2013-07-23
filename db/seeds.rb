require_relative '../app/helpers/importer_helper'

class Seeder
  include ImporterHelper

  def initialize
    puts "Import processing..."
    load_all_csv_files { |file| parse_csv(file) }
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

seed = Seeder.new
seed.display_results