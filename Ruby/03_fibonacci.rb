#!/usr/bin/env ruby

#Aleksandra Gabka, Alexander Pilafian / 2015
#https://fullstackmofo.wordpress.com/2015/07/26/exercise-03-fibonacci-sequence/

$fib_array = [0] #holds the fiboonacci sequence
$last_number = 0 #holds whatever the last number was

def get_n(n) 
    if n == 0
        return $fib_array
    end

    $last_number += $fib_array[-2] || 1 #increment last number by the number before it
    $fib_array.push($last_number)
	
    return get_n(n - 1)
end

#reads input for N (how many fibonacci numbers to ouput)
puts "Enter a number for N (and press <enter>):"
$input = gets.chomp
puts(get_n($input.to_i).join(", "))
