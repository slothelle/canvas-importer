module Sorter
  def identify_data_and_create_objects(row_hash)
    if row_hash.include?(:course_name)
      course = create_or_update(Course, "course_id", row_hash)
      add_course({(course.course_id).to_sym => course})
    elsif row_hash.include?(:user_name)
      student = create_or_update(Student, "user_id", row_hash)
      add_student({(student.user_id).to_sym => student})
      # Save Enrollment object creation for the end
    elsif row_hash.include?(:course_id) && row_hash.include?(:user_id)
      add_enrollment_from(row_hash)
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