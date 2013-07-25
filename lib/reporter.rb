module Reporter
  def generate_txt_report
    courses = Course.that_is_active
    master_list = find_active_courses_and_students
  end

  def generate_csv_report
    courses = Course.that_is_active
    master_list = find_active_courses_and_students
  end

  private
  def find_active_courses_and_students
    master_list = {}
    Enrollment.that_is_active.each do |enrollment|
      course_id = enrollment.course_id
      master_list[course_id.to_sym] = add_course_if_active(enrollment)
      if master_list[course_id.to_sym]
        master_list[course_id.to_sym] << add_student_if_active(enrollment)
      end
    end
    return master_list
  end

  def add_course_if_active(enrollment)
    return [] if enrollment.course_state == 'active'
  end

  def add_student_if_active(enrollment)
    return enrollment.student if enrollment.student_state == 'active'
  end
end