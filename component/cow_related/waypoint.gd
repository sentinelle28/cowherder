extends Node2D

class_name Waypoint
@export var player:Player
var is_following_the_player:bool = false


func _process(delta: float) -> void:
	if is_following_the_player:
		global_position = player.global_position

func _set_follow(value:bool)->void:
	is_following_the_player = value
