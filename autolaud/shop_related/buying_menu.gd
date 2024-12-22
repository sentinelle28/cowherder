extends CanvasLayer
var current_open_buying_stall:BuyingStall
var current_index:int = 0
@export var label_prefab:PackedScene

func _open_menu(buying_stall:BuyingStall)->void:
	show()
	get_tree().paused = true
	Daycycle._stop()
	_set_item_list(buying_stall)
	current_open_buying_stall = buying_stall
	$Panel/Control/Panel/money_label.text = str(Inventory.player_money)

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
	if current_index != null:
		if current_open_buying_stall.can_buy(current_index):
			current_open_buying_stall._add_object_to_player(current_index)
			_set_item_list(current_open_buying_stall)
			$Panel/Control/Panel/money_label.text = str(Inventory.player_money)
			_spawn_label("Bought",Color.GREEN)
			$buy.play()
		else:
			_spawn_label("No money",Color.RED)


func _on_item_list_item_selected(index: int) -> void:
	current_index = index
	$Panel/Control/exchange2/item_texture.texture = current_open_buying_stall.get_texture(index)
	$Panel/Control/exchange/money_requiere.text = str(current_open_buying_stall.get_price(index))

func _spawn_label(text:String,color:Color)->void:
	var new_label:LabelPrefab = label_prefab.instantiate()
	new_label._set_text(text)
	new_label._set_color(color)
	add_child(new_label)
