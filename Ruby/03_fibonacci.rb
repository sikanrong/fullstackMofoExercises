$fib_array = []
$last_number = 0

def get_n(n) 
    if n == 0
        return $fib_array
    end
    
    $fib_array.push($last_number)
    $last_number += $fib_array[-2] || 1
    if (n > 1) && ($fib_array.length == 1)
      $last_number = 1
      $fib_array.push($last_number)
      n -= 1
    end
	
    get_n(n-1)
end

puts(get_n(8).join(", "))

