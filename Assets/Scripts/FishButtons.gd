extends VBoxContainer

onready var FishData = get_parent().get_parent().get_node("FishData")
onready var fishes = FishData.get_fishes()
onready var FishInfo = get_parent().get_parent().get_node("FishInformation")
onready var FishPanel = get_parent().get_parent()

func _ready():
	
	
	for i in range(FishData.fishes.size()):
		var button_instance = Button.new()
		
		button_instance.connect("pressed",self, "_on_button_pressed", [FishData.fishes[i]])
		button_instance.text = FishData.fishes[i].name
		add_child(button_instance)
		

func _on_button_pressed(fish):
	FishInfo.change_label(fish.description)
	FishPanel.change_fish(fish)
