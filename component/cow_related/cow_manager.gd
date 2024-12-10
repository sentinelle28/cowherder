extends Node2D

class_name CowManager
@export var waypoint:Waypoint
@export var time_to_lose_happinnes:float = 60
@export var time_to_gain_happinnes:float = 10
var is_following_the_player:bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child:Node in get_children():
		if child is Cow:
			child.waypoint = waypoint


func _change_mode()->void:
	
	is_following_the_player = not is_following_the_player
	for child:Node in get_children():
		if child is Cow:
			child._set_follow(is_following_the_player)
	waypoint.is_following_the_player = is_following_the_player
	if is_following_the_player == true:
		_pause_happiness()
	else:
		_start_happiness()

func _start_happiness()->void:
	$LoseHappinessTimer.start(time_to_lose_happinnes)
	$HappinessTimer.start(time_to_gain_happinnes)
	
func _pause_happiness()->void:
	$LoseHappinessTimer.stop()
	$HappinessTimer.stop()


func _on_lose_happiness_timer_timeout() -> void:
	for child:Node in get_children():
		if child is Cow:
			child._lose_happiness()
	$LoseHappinessTimer.start(time_to_lose_happinnes)
	$HappinessTimer.stop()
	
func _on_happiness_timer_timeout() -> void:
	for child:Node in get_children():
		if child is Cow:
			child._gain_happiness()
	$HappinessTimer.start(time_to_gain_happinnes)
