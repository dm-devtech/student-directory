require 'csv'

@students = [] # an empty array accessible to all methods
@name = "none"
@cohort = "none"
@hobby = "none"
@countryofbirth = "none"
@height = "none"
loadfilename = "students.csv"

def pushtostudents
  @students << {name: @name, cohort: @cohort.to_sym, hobby: @hobby,
  countryofbirth: @countryofbirth, height: @height}
end

def input_students
  puts "Please enter the names of the students and their cohort"
  puts "To finish, do not enter a name or other details - just press return to skip"
  @students = []
  @name = STDIN.gets.strip
  @cohort = STDIN.gets.strip
  while true do
    if @name.empty? 
      puts "you must enter a name"
      @name = STDIN.gets.strip
    elsif @cohort.empty?
      puts "you must enter a cohort"
      @cohort = STDIN.gets.strip.to_sym
    else 
      break
    end
  end
  puts "enter hobby, birth country, height (press return after each)"
  @hobby, @countryofbirth, @height = STDIN.gets.strip, STDIN.gets.strip, STDIN.gets.strip
  while !@name.empty? do
    pushtostudents
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else 
      puts "Now we have #{@students.count} students"
    end
    puts "enter a new student: (press return to skip)"
    @name = STDIN.gets.strip
    if !@name.empty? 
      puts "enter a cohort, hobby, country of birth, height (press return after each)"
      @cohort, @hobby, @countryofbirth, @height = STDIN.gets.strip, STDIN.gets.strip, STDIN.gets.strip, STDIN.gets.strip
    else
    end
  end
  @students
end 

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  counter = 1
  new_students = @students.group_by {|x| x[:cohort]}
  cohorts = []
  students.map { |s| s[:cohort] }.uniq.each { |c| cohorts << c }
  newerstudents = []
  new_students.each {|k,v| newerstudents << v}
  while counter <= @students.length do
    newerstudents.flatten.select do |v| 
    puts counter.to_s+"."+ " name: "+v[:name].to_s.split(" ")[0].center(24)
    puts "cohort: "+v[:cohort].to_s.center(30)
    puts "hobby: "+v[:hobby].to_s.center(32)
    puts "country of birth: "+v[:countryofbirth].to_s.center(4)
    puts "height: "+v[:height].to_s.center(26)
    counter += 1
  end  
  end
end 

def print_footer(names)
  if names.count == 1 
    puts "Overall, we have #{names.count} great student"
  else names.count > 1
    puts "Overall, we have #{names.count} great students"
  end
end

def interactive_menu
  @students = []
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit"
end

def load_students_on_startup(loadfilename = "students.csv")
  puts "enter a filename to load"
  loadfilename = "students.csv"
  CSV.foreach(loadfilename)do |h| 
    @name, @cohort, @hobby, @countryofbirth, @height = h.join(",").split(",") 
    pushtostudents 
    end
end

def show_students
  load_students_on_startup
  print_header
  print(@students)
  print_footer(@students)
end

def process(selection)
  case selection
    when "1"
      puts "Ok, moving to input students"
      input_students
    when "2"
      puts "Ok, showing students"
      show_students
    when "3"
      puts "Saving..."
      save_students
    when "4"
      puts "Loading..."
      load_students
    when "9"
      puts "Exiting"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def save_students
  puts "Enter a filename to save"
  savefilename = STDIN.gets.strip
  CSV.open(savefilename, "wb") do |f| 
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:hobby], 
      student[:countryofbirth], student[:height]] 
      csv_line = student_data.join(",").split(",") 
      f.puts csv_line 
    end
  end
end

def load_students(loadfilename = "students.csv")
  puts "enter a filename to load"
  loadfilename = STDIN.gets.strip
  CSV.foreach(loadfilename)do |h| 
    @name, @cohort, @hobby, @countryofbirth, @height = h.join(",").split(",") 
    pushtostudents 
    end
end

def try_load_students
  filename = ARGV.first 
  return if filename.nil? 
  if File.exists?(filename) 
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

interactive_menu