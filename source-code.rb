File.open(__FILE__,"r") do |file| 
  file.readlines.each {|line| puts line}
end