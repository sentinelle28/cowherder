extends Node


var list_of_possible_good:Array[Food] = []

func get_new_good()->Food:
	return list_of_possible_good.pick_random()
