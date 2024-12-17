extends Label

class_name LabelPrefab
func _set_text(new_text:String)->void:
	text = new_text
	
func _set_color(color:Color)->void:
	modulate = color


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
