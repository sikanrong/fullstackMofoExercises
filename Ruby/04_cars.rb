#Aleksandra Gabka, Alexander Pilafian / 2015

require 'json'
json_string = <<-JAVASCRIPT 
{
	"cities": [
		{
			"name": "Madrid",
			"Country": 1,
			"lat": 40.429203,
			"lng": -3.694986
		},
		
		{
			"name": "Barcelona",
			"Country": 1,
			"lat": 41.401229,
			"lng": 2.170912
		},
		
		{
			"name": "Paris",
			"Country": 2,
			"lat": 48.864393,
			"lng": 2.357188
		} 
	],
	
    "people": [
        {
            "name": "Alicia",
            "bank_balance": 188.12,
            "passport_no": "D01982711",
            "weight": 60.2,
            "heart_rate": 90,
            "age": 21,
            "body_temp": 36.6
        },
        
        {
            "name": "Shane",
            "bank_balance": 9873.11,
            "passport_no": "D99887123",
            "weight": 80.2,
            "heart_rate": 101,
            "age": 22,
            "body_temp": 41.6
        },
        
        {
            "name": "Bob",
            "bank_balance": 1076.11,
            "passport_no": "S654648132",
            "weight": 99.9,
            "heart_rate": 77,
            "age": 6,
            "body_temp": 36.8
        }
    ],
		
	"animals": [
 		{
 		    "name": "Sparky",
 		    "weight": 20.76,
 		    "heart_rate": 210,
 		    "age": 6,
 		    "body_temp": 35.0
 		},
		
 		{
 		    "name": "Cindy",
 		    "weight": 16.76,
 		    "heart_rate": 220,
 		    "age": 10,
 		    "body_temp": 30.0
 		}
	] 
}

JAVASCRIPT

class Util
  def self.power(num, pow)
  num ** pow
  end
  
  def self.get_distance(lat1, long1, lat2, long2)
    dtor = Math::PI/180
    r = 6378.14
 
    rlat1 = lat1 * dtor 
    rlong1 = long1 * dtor 
    rlat2 = lat2 * dtor 
    rlong2 = long2 * dtor 

    dlon = rlong1 - rlong2
    dlat = rlat1 - rlat2

    a = power(Math::sin(dlat/2), 2) + Math::cos(rlat1) * Math::cos(rlat2) * power(Math::sin(dlon/2), 2)
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))
    d = r * c
    return d
  end
end
class Car
  attr_accessor :fuel, :passengers
  def initialize(fuel, current_city)
    @fuel = fuel
    @current_city = current_city
    @passengers = []
    @total_weight = 0
  end
  
  def get_on(passenger)
    @passengers.push(passenger)
    @total_weight += passenger.weight
  end
  
  def get_off(passenger)
    @passengers.delete(passenger)
  end
  
  def travel(dest_city)
    lat1 = @current_city.lat
    long1 = @current_city.lng
    lat2 = dest_city.lat
    long2 = dest_city.lng
    
    d = Util.get_distance(lat1, long1, lat2, long2)
    
    puts "#{@current_city.name} to #{dest_city.name}: #{d}"

    fuel_rate = 200 - 2 * (@total_weight / 10)
    @fuel -= d / fuel_rate
    
    @passengers.each do |passenger|
      passenger.pay_customs() if ((passenger.is_a? Human) && (@current_city.country != dest_city.country))
      
    end
    
    @current_city = dest_city
    
  end
  

end

class City
  attr_accessor :lat, :lng, :country, :name
  def initialize(name, country, lat, lng)
    @name = name
    @country = country
    @lat = lat
    @lng = lng
  end
end

class Animal 
  attr_accessor :name, :weight, :age
  
  def initialize(name, weight, age)
    @name = name
    @weight = weight
    @age = age
   # params.each { |name, value| instance_variable_set("@#{name}", value) }
    
  end
  
end

class Human < Animal
  attr_accessor :name, :bank_balance, :weight, :age
  def initialize(name, bank_balance, weight, age)
    @bank_balance = bank_balance
    super(name, weight, age)
  end
  
  def pay_customs()
    @bank_balance -= 2.5 * @age
  end
  
end

$data_hash = JSON.parse(json_string)
puts $data_hash
  
$animals = Hash.new
$people = Hash.new
$cities = Hash.new

  
$data_hash["animals"].each do |obj|
  $animals[obj["name"]] = Animal.new(obj["name"], obj["weight"], obj["age"],)
end

$data_hash["people"].each do |obj|
  $people[obj["name"]] = Human.new(obj["name"], obj["bank_balance"], obj["weight"], obj["age"])
end

$data_hash["cities"].each do |obj|
  $cities[obj["name"]] = City.new(obj["name"], obj["Country"], obj["lat"], obj["lng"])
end

car = Car.new(100, $cities["Barcelona"])
car.get_on($people["Alicia"])
car.get_on($people["Shane"])
car.get_on($people["Bob"])
car.get_on($animals["Sparky"])

car.travel($cities["Madrid"])
car.travel($cities["Paris"])

car.get_off($people["Shane"])
car.get_on($animals["Cindy"])
puts car.passengers
car.travel($cities["Barcelona"])

puts "Remaining money:"
$people.each do |pair|
  person = pair.last
  puts "#{person.name} : #{person.bank_balance}"
end

puts "Remaining gas:"
puts car.fuel