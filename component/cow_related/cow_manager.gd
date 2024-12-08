extends Node2D

class_name CowManager
@export var waypoint:Waypoint
var is_following_the_player:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child:Cow in get_children():
		child.waypoint = waypoint


func _change_mode()->void:
	is_following_the_player = not is_following_the_player
	for child:Cow in get_children():
		child._set_follow(is_following_the_player)
	waypoint.is_following_the_player = is_following_the_player
