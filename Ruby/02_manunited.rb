#!/usr/bin/env ruby

#Alex Pilafian - "Manchester United"-themed data parsing program. 2015
#https://docs.google.com/document/d/1NWtzQj1irzL86cv3A48HVxWdT2tRpJw7UQ8dWYHaHgA/edit?usp=drive_web

#The $-sign just denotes a global variable. 
$scores = "Manchester United 1 Chelsea 0, Arsenal 1 Manchester United 1, Manchester United 3 Fulham 1, Liverpool 2 Manchester United 1, Swansea 2 Manchester United 4"


def is_number?(str)
  #returns true if it can cast the string as a Float, and false if there is an error during the casting process.
  true if Float(str) rescue false
end



games_ar = Array.new

#this next block parses the input into a 'games' array. Each item in this array is a nested hash of data. 
#A sample of a single item in the games array is as follows:
# {
#  :scores => {:home => 1, :away => 1}
#  :teams => {:home => "Arsenal", :away => "Manchester United"}
# }
scores_ar = $scores.split(",")
scores_ar.each do |score_str|
  team_names = Hash.new
  scores = Hash.new
  
  words_ar = score_str.split(" ")
  
  current_key = :home
  
  words_ar.each do |word|
    
    if is_number?(word) #detect if the current 'word' is actually one of the scores
      scores[current_key] = word.to_i
      current_key = :away #after the first score, we now fill in the data for the other team.
    else
      if(!team_names[current_key])
        team_names[current_key] = word
      else
        team_names[current_key] += (" " + word)
      end
    end
    
  end
  
  games_ar.push({:scores=>scores, :teams=>team_names})
  
end


manunited_stats = {
  :wins => 0,
  :draws => 0,
  :defeats => 0,
  :goals_scored => 0,
  :goals_conceded => 0,
  :number_of_points => 0
}

#this loop basically just collates the data that we parsed from the input string in the previous loop
games_ar.each do |game|
  
  #these next two lines basically figure out which team in the 'game' Hash is manchester united (:home or :away)
  manunited_key = (game[:teams][:home] == "Manchester United")? :home : :away
  opposition_key = (manunited_key == :home)? :away : :home
  
  manu_score = game[:scores][manunited_key]
  oppo_score = game[:scores][opposition_key]
  
  points = 0 #variable used the tally the 'points' for the final display
  
  #simple data collation
  if(manu_score > oppo_score)
    manunited_stats[:wins] += 1
    points += 3
  elsif(manu_score == oppo_score)
    manunited_stats[:draws] += 1
    points += 1
  elsif(manu_score < oppo_score)
    manunited_stats[:defeats] += 1
  end
  
  manunited_stats[:number_of_points] += points
  manunited_stats[:goals_scored] += manu_score
  manunited_stats[:goals_conceded] += oppo_score
  
end

#print the final results
manunited_stats.each do |k,v|
  puts "#{k} = #{v}"
end

#tomaYA!