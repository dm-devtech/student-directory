@students = [] # an empty array accessible to all methods

def input_students
  puts "Please enter the names of the students and their cohort"
  puts "To finish, do not enter a name or other details - just press return to skip"
  #create an empty array
  @students = []
  #get the first name
  name = gets.strip
  puts "enter a cohort"
  cohort = gets.strip.to_sym
  while true do
    if name.empty? 
      puts "you must enter a name"
      name = gets.strip
    elsif cohort.empty?
      puts "you must enter a cohort"
      cohort = gets.strip.intern
    else 
      break
    end
  end
  puts "enter hobby"
  hobby = gets.strip
  puts "enter birth country"
  countryofbirth = gets.strip
  puts "enter height"
  height = gets.strip
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {name: name, cohort: cohort, hobby: hobby,
    countryofbirth: countryofbirth, height: height}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else 
      puts "Now we have #{@students.count} students"
    end
    puts "enter a new student: (press return to skip)"
    name = gets.strip
    if !name.empty? 
      puts "enter a cohort"
      cohort = gets.strip.to_sym
      puts "enter hobby"
      hobby = gets.strip
      puts "enter birth country"
      countryofbirth = gets.strip
      puts "enter height"
      height = gets.strip
    else
    end
  end
    #return the array of students
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
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print(@students)
  print_footer(@students)
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end

def save_students
  #open the file for writing
  file = File.open("students.csv", "w") #have to open the file first
  #iterate over the students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]] #on every iteration creates array with name and cohort
    csv_line = student_data.join(",") #convert to comma separated string and joins all elements from the string
    file.puts csv_line #writes data to file
  end
  file.close
end

interactive_menu