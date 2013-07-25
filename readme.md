## Instructions for ~Magical~ CLI CSV Parser

CLI app to mass-import CSVs of Students, Courses, and Enrollments.

The following assumptions are made:

1. Each CSV includes (a) ```course_id```, (b) ```user_id```, or (c) ```course_id``` *and* ```user_id```.
2. The file has been unzipped and the CSVs are stored inside of the ```db/csv``` folder.
3. Enrollments are created with pre-existing Student and Course objects. As a result...
4. Files are processed in order, but those that meet the condition for Enrollment objects are processed differently. Instead of being added to the databse immediately, they are saved for last to ensure that all Student and Course objects have been created in the database. This is great because if an institution decides to get liberal with their file organization, the importer will still work.

### Schema
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
### Usage
1. ```$ git clone https://github.com/feministy/canvas_importer.git```
2. ```$ bundle install```
3. Confirm that the CSV files you wish to import/read are stored inside of ```db/csv``` and that they meet the requirements noted above. Adjust models and migrations if your files differ in format prior to next step.
4. ```$ rake db:setup```. This will (a) create a sqlite database, (b) run migrations, (c) load and parse CSVs, (d) seed the database.
5. ```ruby app.rb txt``` or ```ruby app.rb csv``` to generate a plain text or CSV report for all active courses listing all active students.

**To access the database directly:**
```$ sqlite3 /path/to/canvas-importer.db```

**To access the console and current environment:**
```$ rake console```