extends CharacterBody2D

class_name Player
@export var speed:int = 200
@export var cow_manager:CowManager
@export var last_cow:Cow

var tool_list:Array[Callable] = [_show_handbook,_call_cow,_inspect_cow,_feed_cow]

func _ready() -> void:
	Daycycle._start()
	ToolInventory.show()
	ToolInventory._reset_tool()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_move()
	_use_tool()
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
	cow_manager._change_mode()

func _inspect_cow()->void:
	if last_cow != null:
		InspectCows._inspect_cow(last_cow)
		Daycycle._stop()

func _on_cow_detector_body_entered(body: Node2D) -> void:
	if body is Cow:
		last_cow = body


func _on_cow_detector_body_exited(body: Node2D) -> void:
	if body == last_cow:
		last_cow = null


func _use_tool()->void:
	if Input.is_action_just_pressed("use_tool"):
		tool_list[ToolInventory.get_current_tool()].call()
		
func _show_handbook()->void:
	Handbook._show_handbook()

func _feed_cow()->void:
	if last_cow != null and $hands.get_child_count() > 0:
		last_cow._add_new_affix($hands.get_child(0))

func _add_carriable_object(object:Food)->void:
	object.reparent($hands)
	object.position = Vector2(0,0)

func can_carry(object:Food)->bool:
	return $hands.get_child_count() == 0
