extends CanvasLayer

var current_page:int = 0
var max_page:int = 3


func _change_tool(value:int)->void:
	current_page -= value
	if current_page < 0:
		current_page = max_page - 1
	elif current_page > max_page - 1:
		current_page = 0
	_update_page()
	
func _show_handbook()->void:
	get_tree().paused = true
	show()
	current_page = 0
	_update_page()
	Daycycle._stop()
	
func _update_page()->void:
	pass
	

func _quit()->void:
	hide()
	get_tree().paused = false
	Daycycle._start()


func _on_next_pressed() -> void:
	_change_tool(1)
	
func _on_previous_pressed() -> void:
	_change_tool(-1)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape") and visible:
		_quit()
