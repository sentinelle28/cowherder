extends Node

class Milk:
	var number_in_stock:int = 0
	var color:Color = Color.WHITE
	var price:int = 0
	
	func _init(new_color:Color,new_price:int) -> void:
		color = new_color
		number_in_stock += 1
		price = new_price
		
	func _add_milk()->void:
		number_in_stock += 1
		
	func has_milk(number_of_milk_needed:int)->bool:
		return number_in_stock > number_of_milk_needed

	func get_amount_of_milk()->int:
		return number_in_stock
		
	func get_milk_color()->Color:
		return color
		
	func get_price()->int:
		return price
	
	func _set_amount(value:int)->void:
		number_in_stock = value

var MilkName:Array[String] = ["Common"]
var MilkObject:Array[Milk] = [Milk.new(Color.WHITE,1)]
var player_money:int = 0

func _reset()->void:
	MilkName = ["Common"]
	MilkObject = [Milk.new(Color.WHITE,1)]

func get_milk(milkname:String)->Milk:
	if milkname in MilkName:
		return find_correspondant(milkname)
	return null
	
func get_amount_of_milk(milkname:String)->int:
	var milk:Milk = get_milk(milkname)
	if milk != null:
		return milk.get_amount_of_milk()
	return 0

func _add_milk(milkname:String)->void:
	if milkname in MilkName:
		find_correspondant(milkname)._add_milk()
		
func find_correspondant(milkname:String)->Milk:
	var index:int = MilkName.find(milkname)
	return MilkObject[index]
	
func _create_new_milk(milkname:String,color:Color)->void:
	MilkName.append(milkname)
	var temp_array:PackedStringArray = milkname.split(" ",false)
	var cost:int = len(temp_array)*(randi_range(2,6)) + randi_range(-3,3)
	
	MilkObject.append(Milk.new(color,cost))

func get_milk_color(milkname:String)->Color:
	var milk:Milk = get_milk(milkname)
	if milk != null:
		return milk.get_milk_color()
	return Color.WHITE

func has_milk(milk_name:String)->bool:
	return milk_name in MilkName

func _sell(milk_name:String)->void:
	if has_milk(milk_name):
		if get_amount_of_milk(milk_name) > 0:
			player_money += get_price(milk_name)
			_set_amount_of_milk(milk_name,get_amount_of_milk(milk_name)-1)
			
func _set_amount_of_milk(milk_name:String,number:int)->void:
	find_correspondant(milk_name)._set_amount(number)
	
func get_price(milk_name:String)->int:
	return find_correspondant(milk_name).get_price()

func can_buy(price:int)->bool:
	return price <= player_money

func _buy(price:int)->void:
	player_money -= price

func get_variety_number()->int:
	return len(MilkName)

func get_milk_with_index(index:int)->String:
	return MilkName[index]
