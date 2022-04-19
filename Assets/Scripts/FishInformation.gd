extends VBoxContainer

func change_money(money):
	$Money.text = "Money: " + str(money)

func change_label(txt):
	$Label.text = txt

func change_price(price):
	$Price.text = price

func change_amount(amount):
	$Amount.text = amount

func _ready():
	pass
	
