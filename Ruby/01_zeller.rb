#!/usr/bin/env ruby

#Alex Pilafian - Zeller Algorithm. 2015
#https://docs.google.com/document/d/1BKHrV0SEhblnPUgcISKV1oIJ8ejC6jjhtXs_jX8CbWU/edit

$days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

print "Enter your date of birth (dd/mm/yyyy):\n"

input = gets.chomp

#validating the input isn't the point of this exercise. Just parsing it and performing the Zeller algo.

#split(delimiter) will breat a string into an array around the character specified. 
#You can review all of the String methods available here: http://ruby-doc.org/core-2.2.0/String.html
date_ar = input.split("/"); 

#just a string of the normal year like "2001"
fourdigit_year_str = date_ar[2]

day = date_ar[0].to_i 
month = date_ar[1].to_i - 2 #subtract 2 from the month since years used to start in march (which this algorithm depends on)
century = fourdigit_year_str[0..1].to_i #make an int from the first half of the year string
year = fourdigit_year_str[2..3].to_i #same thing with the second half

#adjust all of the other variables due to the weird year-starting-in-march thing...

if(month <= 0) #if we've rewound the month past the first month
  month += 12 
  year -= 1 #then subtract a year
  
  if(year < 0) #if the year's gone less than 1
    year += 100
    century -= 1 #then subtract a century
  end
end

#the zeller stuff is perfect. 
w = (13 * month - 1) / 5 
x = year / 4
y = century / 4
z = w + x + y + day + year - 2 * century 
r = z % 7
if r < 0
    r += 7
end

#The days are in an array and r is just the index of the desired day. 
week_day = $days[r];
puts "You were born on #{week_day}."