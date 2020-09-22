def input_students
  puts "Please enter the names of the students"
  puts "To finish, do not enter a name or other details - just press return to skip"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  puts "enter hobby"
  hobby = gets.chomp
  puts "enter birth country"
  countryofbirth = gets.chomp
  puts "enter height"
  height = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    students << {name: name, cohort: :november, hobby: hobby, 
    countryofbirth: countryofbirth, height: height}
    puts "Now we have #{students.count} students"
    puts "enter a new student: (press return to skip)"
    name = gets.chomp
    if !name.empty? 
      puts "enter hobby"
      hobby = gets.chomp
      puts "enter birth country"
      countryofbirth = gets.chomp
      puts "enter height"
      height = gets.chomp
    else
    end
  end 
  #return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  counter = 1
    while counter <= students.length do
        students.select do |v| 
          puts counter.to_s+". "+v[:name]
          puts "cohort: "+v[:cohort].to_s
          puts "hobby: "+v[:hobby].to_s
          puts "country of birth: "+v[:countryofbirth].to_s
          puts "height: "+v[:height].to_s
          counter += 1
        end  
    end 
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print(students)
print_footer(students)