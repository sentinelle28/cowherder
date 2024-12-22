extends CanvasLayer


func _change_scene(scene:String)->void:
	show()
	$AnimationPlayer.play("scene_transition")
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file(scene)
	hide()
	ToolInventory.show()
