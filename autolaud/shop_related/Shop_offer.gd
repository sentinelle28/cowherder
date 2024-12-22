extends Node


var list_of_possible_good:Array[Food] = [
load("res://component/shoprelated/librarie/egg.tscn").instantiate(),
load("res://component/shoprelated/librarie/watering_can.tscn").instantiate(),
load("res://component/shoprelated/librarie/axe.tscn").instantiate(),
load("res://component/shoprelated/librarie/hoe.tscn").instantiate(),
load("res://component/shoprelated/librarie/rock.tscn").instantiate(),
load("res://component/shoprelated/librarie/log.tscn").instantiate(),
load("res://component/shoprelated/librarie/grass.tscn").instantiate()

]

func get_new_good()->Food:
	return list_of_possible_good.pick_random()
