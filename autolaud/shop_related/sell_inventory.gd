extends CanvasLayer

@export var milk_under:Texture2D
@export var milk_over:Texture2D
@export var label:Label

var last_cliked_item:int = 0
var list_of_milk:Array[String] = ["Common"]





func _on_actual_item_list_item_clicked(index: int, _at_position: Vector2, _mouse_button_index: int) -> void:
	last_cliked_item = index

func _sell()->void:
	Inventory._sell(list_of_milk[last_cliked_item])

func _add_new_milk(milk_name:String)->void:
	list_of_milk.append(milk_name)
	$Panel/background.add_item("",milk_under,false)
	$Panel/actual_item_list.add_item(milk_name + " milk",milk_over)
	$Panel/background.set_item_custom_fg_color(len(list_of_milk) - 1,Inventory.get_milk_color(milk_name))
	
func _update()->void:
	if Inventory.get_variety_number() != len(list_of_milk):
		_update_milk()
	
	
func _update_milk()->void:
	for i:int in range(len(list_of_milk),Inventory.get_variety_number()):
		_add_new_milk(Inventory.get_milk_with_index(i))
	

	
func _activate()->void:
	show()
	Daycycle._stop()
	get_tree().paused = true
	_update()
	


func _on_sell_button_pressed() -> void:
	_sell()
	_update_milk_counter()
	$buy.play()

func _update_milk_counter()->void:
	label.text = str(Inventory.get_amount_of_milk(list_of_milk[last_cliked_item]))


func _on_quit_pressed() -> void:
	GlobaleEscape._quit()
