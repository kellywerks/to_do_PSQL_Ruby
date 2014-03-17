require 'pg'
require './lib/tasks'
require './lib/list'

DB = PG.connect(:dbname => 'to_do')

def welcome_menu
  puts 'What do you need to do today?'
  puts "\nPress 'a' to add a new list."
  puts "Press 'l' to see all of the lists you have."
  puts "Press 'x' to exit."
  user_input = gets.chomp
  case user_input
    when 'a'
      add_list
    when 'l'
      list_lists
    when 'x'
      puts "Good-bye!"
    else
      puts 'Invalid entry, try again.'
      welcome_menu
  end
end

def add_list
  puts "What would you like to name your list?"
  list_name = gets.chomp.upcase
  new_list = List.new(list_name)
  new_list.save
  puts "Your new list was saved."
  welcome_menu
end

def list_lists
  puts "Here are your lists:"
  List.all.each_with_index do |list,index|
    puts "#{index + 1}. #{list.name}"
  end
  puts "\nPlease enter the NAME of a list to work on (or x to exit):"
  list_choice = gets.chomp.upcase
  puts "\nHere are the tasks currently on this list:"
  Task.all.each_with_index do |task,index|
    puts "#{index + 1}.  #{task.name}"
  end
  puts "\nPress a to add a new task."
  puts "Press e to edit a new task."
  puts "Press x to exit."
  case list_choice
  when "a"
    add_task
  when "e"
    edit_task
  when "x"
    welcome_menu
  else
    puts "Invalid choice. Try again."
    list_lists
  end
end

def add_task
  puts "Enter the name of the task to add."
  task_name = gets.chomp
  new_task = Task.new(task_name,list_id)
end

welcome_menu

