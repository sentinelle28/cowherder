extends CharacterBody2D

class_name Cow
@export var range:int = 100
@export var waypoint:Waypoint

var speed:int = 100
var can_move:bool = false
var is_following_the_player:bool = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_move()
	move_and_slide()


func _move()->void:
	if can_move:
		if is_following_the_player:
			_follow_the_player()
		var direction:Vector2 = global_position.direction_to($NavigationAgent2D.get_next_path_position())
		velocity = direction*speed
		_walk_sprite(direction.x)
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.play("idle")

func _walk_sprite(x_direction:float)->void:
	$AnimatedSprite2D.play("walk")
	$AnimatedSprite2D.flip_h = x_direction < 0

func _follow_the_player()->void:
	$NavigationAgent2D.target_position = waypoint.global_position

func _set_follow(value:bool)->void:
	is_following_the_player = value
	can_move = true
	if value == false:
		_chose_new_target()

func _chose_new_target()->void:
	var x:int = generate_range()
	var y:int = generate_range()
	$NavigationAgent2D.target_position = waypoint.global_position + Vector2(x,y)
	

func generate_range()->int:
	return randi_range(-range,range)

func _on_navigation_agent_2d_navigation_finished() -> void:
	if not is_following_the_player:
		$Timer.start(randi_range(2,7))
		can_move = false


func _on_timer_timeout() -> void:
	can_move = true
	_chose_new_target()
