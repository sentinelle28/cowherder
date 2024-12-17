extends Node


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		BuyingMenu.hide()
		SellInventory.hide()
		Handbook.hide()
		InspectCows.hide()
		get_tree().paused = false
		Daycycle._start()
