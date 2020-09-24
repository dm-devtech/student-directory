# Above is the currently executed file name.  This line and below is the source code

puts __FILE__

File.open(__FILE__, 'r') do |thisfile| 
  thisfile.readlines.each do |eachline| 
    puts eachline
  end
end

#test line 1 text
#test line 2 text
