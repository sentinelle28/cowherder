extends Node2D

class_name StallBase

var player:Player

func _ready() -> void:
	ToolInventory.connect("change_tool",_change_mode)

func _change_mode()->void:
	if ToolInventory.get_current_tool() == 4:
		$Label.visible = true
	else:
		$Label.visible = false

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player = body
		if not player.is_connected("interact_with_shop",_interaction_with_player):
			player.connect("interact_with_shop",_interaction_with_player)


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player = null

func _interaction_with_player()->void:
	pass
