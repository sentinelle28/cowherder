extends Sprite2D

class_name Food
@export var food_name:String = "carrot"
@export var color:Color

func get_color()->Color:
	return color

func get_food_name()->String:
	return food_name
