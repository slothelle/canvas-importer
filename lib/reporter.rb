module Reporter
  def generate_txt_report
    master_list = find_active_courses_and_students
    print_list = format_txt_report(master_list)
    File.open("active_roster.txt", "w") do |f|
      f.write(print_list)
    end
  end

  def generate_csv_report
    master_list = find_active_courses_and_students
    print_list = format_csv_report(master_list)
    CSV.open("active_roster.csv", "w") do |row|
      if row.tell() == 0
        row << ["Course Name", "Course ID", "Student Name", "Student ID"]
      end
      print_list.each { |item| row << item }
    end
  end

  def find_active_courses_and_students
    master_list = {}
    Course.all.each do |course|
      course_id = course.course_id
      course.enrollments.select do |enrollment|
        if active?(enrollment)
          master_list[course_id.to_sym] = add_active(course.students)
        end
      end
    end
    return master_list
  end

  private
  def active?(enrollment)
    enrollment.student_state == "active" && enrollment.course_state == "active" && enrollment.state == "active"
  end

  def add_active(course_students)
    active_students = course_students.select do |student|
      student if student.state == "active"
    end
    return active_students
  end

  def format_txt_report(master_list)
    print_list = []
    master_list.each do |course, roster|
      print_list << "#{Course.find_by(course_id: course).name} (ID: #{course})\n"
      roster.each do |student|
        print_list << "#{student.name} (ID: #{student.user_id})\n"
      end
      print_list << "\n#{'.' * 25}\n\n"
    end
    return print_list.join
  end

  def format_csv_report(master_list)
    print_list = []
    master_list.each do |course_id, roster|
      course_name = Course.find_by(course_id: course_id).name
      roster.each do |student|
        print_list << [course_name.gsub(/\"|\,/, ""), course_id, student.name, student.user_id]
      end
    end
    return print_list
  end
end