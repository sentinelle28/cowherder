extends Node2D

func _ready() -> void:
	ToolInventory.hide()
	Daycycle._start()

func _on_play_button_pressed() -> void:
	Inventory._reset()
	SceneTransition._change_scene("res://scene/scene_2d/gameplay_scene/gameplay_scene.tscn")
	Daycycle._stop()
