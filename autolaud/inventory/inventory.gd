extends Node

class Milk:
	var number_in_stock:int = 0
	var color:Color = Color.WHITE
	
	func _init(new_color:Color) -> void:
		color = new_color
		number_in_stock += 1
		
	func _add_milk()->void:
		number_in_stock += 1
		
	func has_milk(number_of_milk_needed:int)->bool:
		return number_in_stock > number_of_milk_needed

	func get_amount_of_milk()->int:
		return number_in_stock
		
	func get_milk_color()->Color:
		return color

var MilkName:Array[String] = ["Common"]
var MilkObject:Array[Milk] = [Milk.new(Color.WHITE)]

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
		print("add")
		
func find_correspondant(milkname:String)->Milk:
	var index:int = MilkName.find(milkname)
	return MilkObject[index]
	
func _create_new_milk(milkname:String,color:Color)->void:
	MilkName.append(milkname)
	MilkObject.append(Milk.new(color))

func get_milk_color(milkname:String)->Color:
	var milk:Milk = get_milk(milkname)
	if milk != null:
		return milk.get_milk_color()
	return Color.WHITE

func has_milk(milk_name:String)->bool:
	return milk_name in MilkName
