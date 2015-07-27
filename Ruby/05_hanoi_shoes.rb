#!/usr/bin/env ruby
#
#Aleksandra Gabka, Alexander Pilafian / 2015
#https://fullstackmofo.wordpress.com/2015/07/26/42/

require "green_shoes"

$a = [5, 4, 3, 2, 1, 0]
$b = []
$c = [] 

#Hanoi class is responsible for processing Tower of Hanoi simulations.
class Hanoi
  attr_accessor :steps
  def initialize(source, dest, spare)
    @disk = 5
    @steps = []
    @source = source
    @dest = dest
    @spare = spare
    self.move_tower(@disk, @source, @dest, @spare) #kicks off the hanoi process
  end

  def move_disk(source, dest)
    dest.push(source.pop) #moves the disk from one array to the other
    @steps.push([@source.clone, @dest.clone, @spare.clone]) #record the current state of the discs at this step
  end

  #Recursively moves the tower, following the rules of the game. Ensures that the
  #smaller discs are always moved before the larger ones.
  #
  #The recursion is somewhat complex (here, there be dragons)
  def move_tower(disk, source, dest, spare)
    if disk == 0
      move_disk(source, dest)
	  else
      #magic!
    	move_tower(disk - 1, source, spare, dest)
      move_disk(source, dest)
      move_tower(disk - 1, spare, dest, source)
    end	
  end
end

#Shoes (gem install green_shoes) is a simple ruby GUI library for making 
#Simple applications. Is compatible with GTK toolkit for the GNOME desktop 
#environment on Linux.

Shoes.app(title: "Towers of Hanoi", width: 800, height: 300) do
   background white
   @pegs = []

   (0..2).each { |i|
     @pegs.push rect(
         top: 50,
         left: (200 + (i * 200)),
         width: 10,
         height: 130)
     @pegs[i].style(fill: goldenrod, stroke: darkgoldenrod)
   }

   @bottom_bar = rect(
       top: 180,
       left: 50,
       width: 700,
       height: 10)
   @bottom_bar.style(fill: goldenrod, stroke: darkgoldenrod)

   @colors = [coral, cornflowerblue, teal, gold, greenyellow, indianred]

   @disks = []
   (0..5).each { |i|
     @disks.push rect(
         top: 60 + i * 20,
         left: 175 - i * 10,
         width: 60 + i * 20,
         height: 20)
     @disks[i].style(fill: @colors[i], stroke: @colors[i])
   }

  hanoi = Hanoi.new($a, $b, $c)
  current_step = 0
   
   #text display.
   @counter = subtitle("Current step: #{current_step}",
                       top: 210,
                       align: "center")

   @animate = animate(5) do
     
    step = hanoi.steps[current_step]
    
    if step.nil?
      #stop when it's over
      @animate.stop
      next
    end
    
    step.each_with_index do |peg_ar, peg_index|
      top_pos = @bottom_bar.top
      peg_ar.each { |disk_i|
        peg_disk = @disks[disk_i]
        peg = @pegs[peg_index]
        
        #offset for height of the disc
        top_pos -= peg_disk.height
        
        #changes disk position
        peg_disk.top = top_pos
        peg_disk.left = peg.left - peg_disk.width / 2 + peg.width / 2 
      }
    end
    
    @counter.text = "Current step: #{current_step}"
    current_step += 1
  end
  
end
