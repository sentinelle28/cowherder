extends StallBase



func _interaction_with_player()->void:
	if player != null:
		SellInventory._activate()
