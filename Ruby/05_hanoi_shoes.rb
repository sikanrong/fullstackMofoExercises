require "green_shoes"

$a = [5, 4, 3, 2, 1, 0]
$b = []
$c = [] 

class Hanoi
  attr_accessor :steps
  def initialize(source, dest, spare)
    @disk = 5
    @steps = []
    @source = source
    @dest = dest
    @spare = spare
    self.move_tower(@disk, @source, @dest, @spare)
  end

  def move_disk(source, dest)
    dest.push(source.pop)
    @steps.push([@source.clone, @dest.clone, @spare.clone])
  end

  def move_tower(disk, source, dest, spare)
    if disk == 0
      move_disk(source, dest)
	  else
    	move_tower(disk - 1, source, spare, dest)
      move_disk(source, dest)
      move_tower(disk - 1, spare, dest, source)
    end	
  end
end

Shoes.app(title: "Towers of Hanoi", 
  width: 800, height: 300) {
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
   @counter = subtitle("Current step: #{current_step}",
                       top: 210,
                       align: "center")

   @animate = animate(5) do
    step = hanoi.steps[current_step]
    if step.nil?
      @animate.stop
      next
    end
    step.each_with_index do |peg_ar, peg_index|
      top_pos = @bottom_bar.top
      peg_ar.each { |disk_i|
        peg_disk = @disks[disk_i]
        peg = @pegs[peg_index]
        top_pos -= peg_disk.height
        peg_disk.top = top_pos
        peg_disk.left = peg.left - peg_disk.width / 2 + peg.width / 2
      }
    end
    @counter.text = "Current step: #{current_step}"
    current_step += 1
  end

 }
