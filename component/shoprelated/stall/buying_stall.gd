extends StallBase

class_name BuyingStall
@export var is_permanent:bool = false
var list_of_good:Array[Food] = []

func _ready() -> void:
	ToolInventory.connect("change_tool",_change_mode)
	Daycycle.connect("dawn",_restock)
	
	if is_permanent:
		_init_permanance()
	else:
		_restock()

func _init_permanance()->void:
	for goods:Food in $stock.get_children():
		list_of_good.append(goods.duplicate())


func _interaction_with_player()->void:
	if player != null and has_stock():
		BuyingMenu._open_menu(self)
		
		


func has_stock()->bool:
	return $stock.get_child_count() > 0

func _restock()->void:
	if is_permanent:
		_restock_permanent()
	else:
		_restock_tempory()
	
func _restock_permanent()->void:
	_void_stock()
	for good:Food in list_of_good:
		$stock.add_child(good.duplicate())
		
	
func _restock_tempory()->void:
	_void_stock()
	for i:int in range(randi_range(3,7)):
		var new_child:Food = ShopOffer.get_new_good().duplicate()
		$stock.add_child(new_child)
		new_child.position = Vector2.ZERO
		

func _void_stock()->void:
	if $stock.get_child_count() != 0:
		for child:Food in $stock.get_children():
			$stock.call_deferred("remove_child",child)

func get_price(index:int)->int:
	return get_food(index).get_price()

func get_texture(index:int)->Texture2D:
	return get_food(index).get_Ctexture()
	
func get_food(index:int)->Food:
	return $stock.get_child(index)

func get_good()->Array[Node]:
	return $stock.get_children()

func _add_object_to_player(index:int)->void:
	if can_buy(index):
		Inventory._buy($stock.get_child(index).get_price())
		player._add_carriable_object($stock.get_child(index))

func can_buy(index:int)->bool:
	return Inventory.can_buy($stock.get_child(index).get_price()) and player.can_carry()
