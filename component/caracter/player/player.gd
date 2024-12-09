extends CharacterBody2D

class_name Player
@export var speed:int = 200
@export var cow_manager:CowManager
@export var last_cow:Cow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_move()
	_inspect_cow()
	_call_cow()
	move_and_slide()


func _move()->void:
	var direction:Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction*speed
	_change_sprite(direction)
	
func _change_sprite(direction:Vector2)->void:
	if abs(direction.x) > abs(direction.y):
		if direction.x < 0:
			$AnimatedSprite2D.play("left")
		else:
			$AnimatedSprite2D.play("right")
	elif abs(direction.x) < abs(direction.y):
		if direction.y < 0:
			$AnimatedSprite2D.play("up")
		else:
			$AnimatedSprite2D.play("down")
	else:
		$AnimatedSprite2D.stop()

func _call_cow()->void:
	if Input.is_action_just_pressed("switch_mode"):
		cow_manager._change_mode()

func _inspect_cow()->void:
	if Input.is_action_just_pressed("inspect"):
		if last_cow != null:
			InspectCows._inspect_cow(last_cow)

func _on_cow_detector_body_entered(body: Node2D) -> void:
	if body is Cow:
		last_cow = body


func _on_cow_detector_body_exited(body: Node2D) -> void:
	if body == last_cow:
		last_cow = null
