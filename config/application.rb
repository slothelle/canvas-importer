require 'pathname'
require 'sqlite3'
require 'active_record'
require 'logger'

# Sets the root file path for the app
APP_ROOT = Pathname.new(File.expand_path(File.join(File.dirname(__FILE__), '..')))

# Sets app name based on the app folder name
APP_NAME = APP_ROOT.basename.to_s

# Puts the database inside of the db/ folder
DB_PATH  = APP_ROOT.join('db', APP_NAME + ".db").to_s

# In the event that we use debugger
if ENV['DEBUG']
  ActiveRecord::Base.logger = Logger.new(STDOUT)
end

# Dynamically loading every model
Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
  filename = File.basename(model_file).gsub('.rb', '')
  autoload ActiveSupport::Inflector.camelize(filename), model_file
end

# Establishing a connection to our database
ActiveRecord::Base.establish_connection :adapter  => 'sqlite3',
                                        :database => DB_PATH
