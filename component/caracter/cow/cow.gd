extends CharacterBody2D

class_name Cow
@export var scatter_range:int = 100
@export var waypoint:Waypoint

@export_group("milk")
@export var amount_of_milk_created:int = 3
@export var time_to_produce_milk:float = 10
@export var milk_name:String = "Common" 


var speed:int = 100
var can_move:bool = false
var is_following_the_player:bool = false

var curent_happiness:int = 50
var current_feedness:int = 50

var is_sleeping:bool = false

func _ready() -> void:
	$milk_timer.start(time_to_produce_milk)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_move()
	move_and_slide()


func _move()->void:
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play("idle")
	if can_move and is_following_the_player:
		_follow_the_player()
		var direction:Vector2 = global_position.direction_to($NavigationAgent2D.get_next_path_position())
		velocity = direction*speed
		_walk_sprite(direction.x)
	elif can_move and not is_following_the_player:
		if not is_sleeping:
			var direction:Vector2 = global_position.direction_to($NavigationAgent2D.get_next_path_position())
			velocity = direction*speed
			_walk_sprite(direction.x)
			$AnimationPlayer.play("RESET")
		else:
			$AnimationPlayer.play("sleeping")
	

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
	return randi_range(-scatter_range,scatter_range)

func _on_navigation_agent_2d_navigation_finished() -> void:
	if not is_following_the_player:
		$wait_timer.start(randi_range(2,7))
		can_move = false


func _on_timer_timeout() -> void:
	if not Daycycle.is_night():
		is_sleeping = false
		can_move = true
		_chose_new_target()
	else:
		$wait_timer.start(10)
		is_sleeping = true


func _on_milk_timer_timeout() -> void:
	$milk_timer.start(time_to_produce_milk)
	if curent_happiness >= 50 and current_feedness >= 30 and not is_sleeping:
		current_feedness -= 10
		
		Inventory._add_milk(milk_name)


func get_milk_color()->Color:
	return Inventory.get_milk_color(milk_name)

func get_amount_of_milk()->int:
	return Inventory.get_amount_of_milk(milk_name)


func _gain_happiness()->void:
	curent_happiness += randi_range(0,3)
	
func _lose_happiness()->void:
	curent_happiness += randi_range(-4,-1)
