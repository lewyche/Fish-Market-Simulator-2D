extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	$Buy.connect("pressed", self, "_on_button_pressed", [1])
	$BuyTen.connect("pressed", self, "_on_button_pressed", [10])
	$BuyHundred.connect("pressed", self, "_on_button_pressed", [100])

func _on_button_pressed(num):
	get_parent().get_parent().buy(num)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
