extends Sprite2D

class_name Food
@export var food_name:String = "carrot"
@export var color:Color
@export var price:int = 10

func get_color()->Color:
	return color

func get_food_name()->String:
	return food_name

func get_price()->int:
	return price

func get_Ctexture()->Texture2D:
	return texture.duplicate()
