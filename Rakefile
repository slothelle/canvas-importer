require 'rake'
require 'csv'
require 'rspec/core/rake_task'
require_relative 'config/application'

desc "drop the database"
task "db:drop" do
  puts "Deleting #{DB_PATH}..."
  rm_f DB_PATH
end

desc 'Start IRB with application environment loaded'
task "console" do
  exec "irb -r./config/application"
end

desc 'Create, migrate, and seed the database from db/csv'
task "db:setup" do
  # Create database
  puts "Creating database..."
  touch DB_PATH

  # Run migrations
  puts "\nRunning migrations..."
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end

  # Seed the database by parsing CSV files
  # The seeder is chatty and provides progress updates
  require APP_ROOT.join('lib', 'sorter.rb')
  require APP_ROOT.join('lib', 'importer.rb')
  require APP_ROOT.join('db', 'seeds.rb')
  require APP_ROOT.join('config', 'application.rb')
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:spec)

task :default  => :specs
