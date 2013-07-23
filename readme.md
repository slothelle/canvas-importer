## Instructions for CLI ~Magical~ CSV Parser

CLI app to mass-import CSVs of Students, Courses, and Enrollments. While the importer itself does not make too many assumptions about the data available, it does require that each CSV row include: (a) ```course_id```, (b) ```user_id```, or (c) ```course_id``` *and* ```user_id```.

#### Schema
```sql
CREATE TABLE "courses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "course_id" varchar(255) NOT NULL, "state" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "enrollments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "student_id" integer NOT NULL, "course_id" integer NOT NULL, "state" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "students" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255) NOT NULL, "user_id" varchar(255) NOT NULL, "state" varchar(255) NOT NULL, "created_at" datetime, "updated_at" datetime);
CREATE UNIQUE INDEX "index_courses_on_course_id" ON "courses" ("course_id");
CREATE UNIQUE INDEX "index_enrollments_on_course_id_and_student_id" ON "enrollments" ("course_id", "student_id");
CREATE UNIQUE INDEX "index_students_on_user_id" ON "students" ("user_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
```

1. ```$ git clone https://github.com/feministy/canvas_importer.git```
2. ```$ bundle install```
3. ```$ rake db:create && $ rake db:migrate```
4. Confirm that the CSV files you wish to import/read are stored inside of ```../db/csv``` and that they meet the requirements noted above.
5. ```$ rake db:seed```
6. Final step TBD :)

**To access the database directly:**
```$ sqlite3 /path/to/canvas-importer.db```

**To access the console and current environment:**
```$ rake console```