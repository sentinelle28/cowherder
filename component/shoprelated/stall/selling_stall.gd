extends StallBase

func _ready() -> void:
	ToolInventory.connect("change_tool",_change_mode)

func _interaction_with_player()->void:
	if player != null:
		SellInventory._activate()

func _change_mode()->void:
	if ToolInventory.get_current_tool() == 4:
		$Label.visible = not $Label.visible
