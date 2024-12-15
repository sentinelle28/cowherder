extends StallBase

func _ready() -> void:
	if $stock.get_child_count() > 0:
		$Label.text = str($stock.get_child(0).get_price())

func _interaction_with_player()->void:
	if player != null and has_stock():
		if Inventory.can_buy($stock.get_child(0).get_price()) and player.can_carry():
			Inventory._buy($stock.get_child(0).get_price())
			player._add_carriable_object($stock.get_child(0))


func has_stock()->bool:
	return $stock.get_child_count() > 0
