extends Node

class Fish:
	var name: String
	var description: String
	var min_price: int
	var max_price: int
	
	func _init(n, d, min_p, max_p):
		name = n
		description = d
		min_price = min_p
		max_price = max_p
		
var sigma_fish = Fish.new("Sigma Fish",
 "Found in north america, known for its anti-social behavior, passionate mindset and headstrong attitude.",
5,
85)

var beta_fish = Fish.new("Beta Fish",
"Despite the plentiful fish in the sea, it still can’t get any mates.",
1,
50)

var long_fish = Fish.new("Long Fish",
"About as long as an earthworm.",
12,
55)

var cyclops_fish = Fish.new("Cyclops Fish",
"Actually has two eyes, the other one is just on the other side",
7,
70)

var blorb_fish = Fish.new("Blorb Fish",
"Achieves classic shape through selective breeding. In extreme pain all the time.",
25,
100)

var sparkle_fish = Fish.new("Sparkle Fish", 
"Most known for as being the weapon used to assassinate King Wolfgang the 3.14",
50,500
)

var fishes = [sigma_fish, beta_fish, long_fish, cyclops_fish, blorb_fish, sparkle_fish]

func get_fishes():
	return fishes

func _ready():
	pass
