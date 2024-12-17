extends AudioStreamPlayer

func _ready() -> void:
	_start()

func _start()->void:
	play()
	
func _stop()->void:
	stop()
	$Timer.stop()
	


func _on_finished() -> void:
	$Timer.start(randi_range(3,10))


func _on_timer_timeout() -> void:
	_start()
