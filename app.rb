require_relative 'config/application'
require_relative 'lib/reporter'
require 'csv'

class UserCommand
  include Reporter

  def initialize(command)
    @command = command.join
    run_reporter
  end

  def run_reporter
    if @command == "txt"
      generate_txt_report
    elsif @command == "csv"
      generate_csv_report
    elsif @command == "flee"
      puts "Goodbye!"
    else
      puts "Sorry, I don't know what '#{@command}' means!"
    end
  end
end

UserCommand.new(ARGV)