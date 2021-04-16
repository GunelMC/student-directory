require 'CSV'
require 'colorize'
@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

# extract repeat code into a method
def insert_list(p_name, p_cohort)
   @students << {name: p_name, cohort: p_cohort.to_sym}
end 

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp  # get the first name
  while !name.empty? do # while the name is not empty, repeat this code
    insert_list(name, "april") # add the student hash to the array
    if @students.count > 1
      puts "Now we have #{@students.count} students"
    else
      puts "Now we have #{@students.count} student"
    end
    name = STDIN.gets.chomp # get another name from the user
  end
  @students
end 


def print_header
  puts "The students of Villains Academy".center(172)
  puts "-------------".center(172).colorize(:blue)
end 

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)".center(172)
  end
end 

def print_footer
  if @students.count > 1
    puts "Overall, we have #{@students.count.to_s.colorize(:red)} great students".center(187)
  else
    puts "Overall, we have #{@students.count.to_s.colorize(:red)} great student".center(187)
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  file = File.open("students.csv", "w") # open the file for writing
  @students.each do |student| # iterate over the array of students
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end 

def load_students (filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(",")
   insert_list(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line

  if filename.nil? # make the program load students.csv by default if no file is given on startup
    filename = 'students.csv' # get out of the method if it isn't given
  end

  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end 
end 

#refactor the process method 
def process(selection)
  options = {"1" => "input_students","2" => "show_students","3" => "save_students", "4" => "load_students"}
  if options[selection]
    method(options[selection]).call
  elsif selection == "9"
    exit 
  else
    puts "I don't know what you meant, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end 
end 

try_load_students
interactive_menu