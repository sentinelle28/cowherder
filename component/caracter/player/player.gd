extends CharacterBody2D

class_name Player
@export var speed:int = 3000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move()
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
