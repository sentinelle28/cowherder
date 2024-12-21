extends Node


var list_of_possible_good:Array[Food] = [
load("res://component/shoprelated/librarie/egg.tscn").instanciate(),
load("res://component/shoprelated/librarie/watering_can.tscn").instanciate(),
load("res://component/shoprelated/librarie/axe.tscn").instanciate(),
load("res://component/shoprelated/librarie/hoe.tscn").instanciate(),
load("res://component/shoprelated/librarie/rock.tscn").instanciate(),
load("res://component/shoprelated/librarie/log.tscn").instanciate(),
load("res://component/shoprelated/librarie/grass.tscn").instanciate()

]

func get_new_good()->Food:
	return list_of_possible_good.pick_random()
