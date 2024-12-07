extends CharacterBody2D

class_name Cow

@export var player:Player

var target:Vector2
var speed:int = 100
var can_move:bool = false
var is_following_the_player:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_follow(true)


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
	target = player.global_position
	$NavigationAgent2D.target_position = player.global_position

func _set_follow(value:bool)->void:
	is_following_the_player = value
	can_move = true


func _on_navigation_agent_2d_navigation_finished() -> void:
	pass # Replace with function body.
