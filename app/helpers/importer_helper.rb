require_relative '../../config/application.rb'

module ImporterHelper
  def load_all_csv_files
    Dir["db/csv/*.csv"].each { |file| yield file }
  end

  def parse_csv(filename)
    print "."
    CSV.foreach(filename, :headers => true, :header_converters => :symbol, :converters => :all) do |row_hash|
      new_entry = Hash[row_hash]
      # Create in DB & store in hash for faster lookup later
      if new_entry.include?(:course_name)
        course = create_or_update(Course, "course_id", new_entry)
        add_course({(course.course_id).to_sym => course})
      elsif new_entry.include?(:user_name)
        student = create_or_update(Student, "user_id", new_entry)
        add_student({(student.user_id).to_sym => student})
      elsif new_entry.include?(:course_id) && new_entry.include?(:user_id)
        add_enrollment_from(new_entry)
      end
    end
  end

  def create_or_update(table, unique_field, row_hash)
    entry = table.find_by(unique_field.to_sym => row_hash[unique_field.to_sym])
    if entry
      entry.update_attributes(row_hash)
    else
      entry = table.create(row_hash)
    end
    return entry
  end

  def create_enrollments
    # Assumes that objects exist & are stored in hashes
    enrollment.each do |row|
      user_id = row[:user_id]
      course_id = row[:course_id]
      Enrollment.create(student: students[user_id.to_sym], course: courses[course_id.to_sym], state: row[:state])
    end
  end

  def students
    @students = Hash.new if @students.nil?
    @students if @students.length >= 0
  end

  def add_student(student_hash)
    students.merge!(student_hash)
  end

  def courses
    @courses = Hash.new if @courses.nil?
    @courses if @courses.length >= 0
  end

  def add_course(course_hash)
    courses.merge!(course_hash)
  end

  def enrollment
    @enrollment = [] if @enrollment.nil?
    @enrollment if @enrollment.length >= 0
  end

  def add_enrollment_from(row_hash)
    enrollment << row_hash
  end
end