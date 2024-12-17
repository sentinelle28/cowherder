extends CanvasLayer
var current_open_buying_stall:BuyingStall
var current_player:Player

func _open_menu(buying_stall:BuyingStall,player:Player)->void:
	current_player = player
	show()
	get_tree().paused = true
	Daycycle._stop()
	_set_item_list(buying_stall)
	current_open_buying_stall = buying_stall

func _quit()->void:
	hide()
	get_tree().paused = false
	Daycycle._start()


func _set_item_list(buying_stall:BuyingStall)->void:
	_clear_item()
	_add_item(buying_stall)
	
func _add_item(buying_stall:BuyingStall)->void:
	for good:Food in buying_stall.get_good():
		$Panel/ItemList.add_item(good.get_food_name(),good.get_Ctexture())
		
func _clear_item()->void:
	$Panel/ItemList.clear()


func _on_buy_button_pressed() -> void:
	pass # Replace with function body.


func _on_item_list_item_selected(index: int) -> void:
	$Panel/Control/exchange2/item_texture.texture = current_open_buying_stall.get_texture(index)
	$Panel/Control/exchange/money_requiere.text = str(current_open_buying_stall.get_price(index))
