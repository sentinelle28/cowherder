extends CharacterBody2D

class_name Cow
@export_group("scatter behavior")
@export var scatter_range:int = 100
@export var waypoint:Waypoint

@export_group("milk")
@export var amount_of_milk_created:int = 3
@export var time_to_produce_milk:float = 10
@export var milk_name:String = "Common" 
@export var label_prefab:PackedScene

@export_group("evolution")
@export var last_food:Food

var speed:int = 100
var can_move:bool = true
var is_following_the_player:bool = false

var current_amount_of_milk:int = 0

var curent_happiness:int = 50
var current_feedness:int = 50

var is_sleeping:bool = false

func _ready() -> void:
	_chose_new_target()
	$milk_timer.start(time_to_produce_milk)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_move()
	move_and_slide()


func _move()->void:
	if $AnimationPlayer.is_playing() and not is_sleeping:
		$AnimationPlayer.play("RESET")
	
	if can_move and is_following_the_player:
		if is_close_to_player():
			_close_behavior()
		else:
			_far_behavior()
	elif can_move and not is_following_the_player:
		if not is_sleeping:
			var direction:Vector2 = global_position.direction_to($NavigationAgent2D.get_next_path_position())
			velocity = direction*speed
			_walk_sprite(direction.x)
		else:
			$AnimationPlayer.play("sleeping")
			velocity = Vector2.ZERO
	else:
		_play_anim("idle")
		velocity = Vector2.ZERO
	

func _walk_sprite(x_direction:float)->void:
	_play_anim("walk")
	$AnimatedSprite2D.flip_h = x_direction < 0

func is_close_to_player()->bool:
	return global_position.distance_to(waypoint.global_position) < 10

func _play_anim(anim:String)->void:
	if $AnimatedSprite2D.animation != anim:
		$AnimatedSprite2D.play(anim)


func _close_behavior()->void:
	_play_anim("idle")
	velocity = Vector2.ZERO
	
func _far_behavior()->void:
	_follow_the_player()
	var direction:Vector2 = global_position.direction_to($NavigationAgent2D.get_next_path_position())
	velocity = direction*speed
	_walk_sprite(direction.x)

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
		amount_of_milk_created += randi_range(4,20)
		amount_of_milk_created = clampi(amount_of_milk_created,0,100)
		if amount_of_milk_created == 100:
			_spawn_label("+ Milk",Inventory.get_milk_color(milk_name))
			amount_of_milk_created -= 100
			Inventory._add_milk(milk_name)


func get_milk_color()->Color:
	return Inventory.get_milk_color(milk_name)


func get_amount_of_milk()->int:
	return amount_of_milk_created


func _gain_happiness()->void:
	curent_happiness += randi_range(0,3)
	current_feedness += randi_range(-3,9)
	curent_happiness = clampi(curent_happiness,0,100)
	current_feedness = clampi(current_feedness,0,100)
	_spawn_label("+ Happy",Color.YELLOW)
	if randi_range(1,10) <= 3:
		$suprised.play()
	elif randi_range(1,10) <= 3:
		$unkown_expression.play()
	
	
func _lose_happiness()->void:
	curent_happiness += randi_range(-4,-1)
	_spawn_label("- Happy",Color.RED)
	$unhappy.play()

func _add_new_affix(affix:Food)->void:
	_update_name(affix)
	_update_affix_visual(affix)
	
func _create_new_milk(affix_color:Color,previous_name:String)->void:
	if not Inventory.has_milk(milk_name):
		var temp_color:Color = (Inventory.get_milk_color(previous_name) + affix_color)/2 + get_random_color()
		Inventory._create_new_milk(milk_name,temp_color)
	
func _update_name(affix:Food)->void:
	var affix_name:String = affix.get_food_name()
	var previous_name:String = milk_name
	if "Common" in milk_name:
		milk_name = affix_name
	else:
		milk_name += " " + affix_name
	_create_new_milk(affix.get_color(),previous_name)

func _update_affix_visual(affix:Food)->void:
	var pos:Vector2 = Vector2(0,-3)
	var new_angle:float = randf_range(0,PI)
	affix.reparent(last_food)
	affix.position = pos
	affix.rotate(new_angle)
	last_food = affix

func get_value_in_range()->int:
		return randi_range(-3,3)
		
func get_random_color()->Color:
	return Color(get_value_in_range(),get_value_in_range(),get_value_in_range())


func _spawn_label(text:String,color:Color)->void:
	var new_label:LabelPrefab = label_prefab.instantiate()
	new_label._set_text(text)
	new_label._set_color(color)
	add_child(new_label)
