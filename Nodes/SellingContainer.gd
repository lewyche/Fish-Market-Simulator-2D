extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sell.connect("pressed", self, "_on_button_pressed", [1])
	$SellTen.connect("pressed", self, "_on_button_pressed", [10])
	$SellHundred.connect("pressed", self, "_on_button_pressed", [100])
	
	
func _on_button_pressed(num):
	get_parent().get_parent().sell(num)
