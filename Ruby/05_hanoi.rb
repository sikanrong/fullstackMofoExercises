$a = [5, 4, 3, 2, 1, 0]
$b = []
$c = []

$step = 0

def move_tower(disk, source, dest, spare)
    
    if disk == 0
	    dest.push(source.pop)
	else
    	move_tower(disk - 1, source, spare, dest)
        dest.push(source.pop)
        move_tower(disk - 1, spare, dest, source)
    end	
    
    $step += 1
    puts $step
    
    puts "a: " + $a.to_s
    puts "b: " + $b.to_s
    puts "c: " + $c.to_s

end
	  
move_tower(5, $a, $b, $c)


