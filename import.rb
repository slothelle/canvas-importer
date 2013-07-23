require_relative 'config/application'

# puts "Put your application code in #{File.expand_path(__FILE__)}"

def all_todos
  Task.all.each do |task|
    puts "Task # #{task.id} | List #{List.find(task.list_id).name} | Task #{task.name} | Completed on #{task.completed_at}"
  end
end

def todos_for_list(id)
  puts "List - #{List.find(id).name}"

  List.find(id).tasks.all.each do |task|
    puts "Task # #{task.id} | Task #{task.name} | Completed on #{task.completed_at}"
  end
end

def add_todo(task, list)
  Task.create(name: task, list_id: list)
end

def delete_todo(id)
  Task.destroy(id)
  TagCloud
end

def complete_todo(id)
  Task.find(id).update_attribute(:completed_at, Time.now)
end 

def display_help_menu
    prompt = <<-COMMANDS
                             ----------------------------
                            | WELCOME TO YOUR TODO LIST: |
                             ----------------------------                            
     ------------------------------------------------------------------------------                                                                              
    | Here are your commands:                                                     |
    | list                              =>List all of the tasks on your todo list |
    | list <name>                       =>List all tasks from a specific list     |
    | add <list name> <task content>    =>Add a task to a specific list           |
    | delete <id>                       =>Delete a task from your list            |
    | complete <id>                     =>Complete a task on your list            |
    | tag <id> <tag name>               =>Tag a task on your list                 |
    | help                              =>Disply list of commands                 |
     ------------------------------------------------------------------------------
    COMMANDS

    puts prompt
end


all_todos if ARGV[0] == 'list' && ARGV.size == 1
todos_for_list(List.find_by_name(ARGV[1]).id) if ARGV[0] == 'list' && ARGV.size > 1
display_help_menu if ARGV[0] == 'help'

if ARGV[0] == "add"
  list = List.find_or_create_by_name(ARGV[1])
  task = ARGV[2..-1].join(" ")
  add_todo(task, list.id)
end

if ARGV[0] == "tag"
  tag = Tag.find_or_create_by_name(ARGV[2])
  task = Task.find(ARGV[1])
  task.tags << tag
end

delete_todo(ARGV[1]) if ARGV[0] == "delete"
complete_todo(ARGV[1]) if ARGV[0] == "complete"
