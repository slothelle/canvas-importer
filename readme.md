## Instructions for CSV Parser & Magic Maker

1. ```$ git clone https://github.com/feministy/canvas_importer.git```
2. ```$ bundle install```
3. ```$ rake db:create```
4. ```$ rake db:migrate```
5. Confirm that the CSV files you wish to import/read are stored inside of ```/db/csv```
6. ```$ rake db:seed```
7. Final step TBD :)

To access the database console: ```sqlite3 /path/to/canvas-importer.db```