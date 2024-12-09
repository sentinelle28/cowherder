extends CanvasLayer

@export var current_inspected_cow:Cow
@onready var happinessmeter:ProgressBar = $Panel/HappinessMeter
@onready var fulnessmeter:ProgressBar = $Panel/FullnessMeter
@onready var namelabel:Label = $Panel/NameLabel
@onready var submitbutton:Button = $Panel/Submitbutton
@onready var editname:TextEdit = $Panel/Submitbutton/EditName

# Called when the node enters the scene tree for the first time.


func _update_meter()->void:
	happinessmeter.value = current_inspected_cow.curent_happiness
	fulnessmeter.value = current_inspected_cow.current_feedness
	$Panel/milkmeter.value = current_inspected_cow.current_amount_of_milk
	$Panel/milkmeter.tint_progress = current_inspected_cow.milk_color


func _inspect_cow(cow_to_inspect:Cow)->void:
	get_tree().paused = true
	show()
	current_inspected_cow = cow_to_inspect
	namelabel.text = cow_to_inspect.name
	_update_meter()
	


func _on_edit_button_pressed() -> void:
	namelabel.hide()
	submitbutton.show()


func _on_submitbutton_pressed() -> void:
	if len( editname.text) >= 3 and current_inspected_cow != null:
		current_inspected_cow.name = editname.text
		namelabel.text = editname.text
		editname.text = ""
		submitbutton.hide()
		namelabel.show()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape") and visible:
		_quit()
		
func _quit()->void:
	hide()
	get_tree().paused = false

func _on_exit_button_pressed() -> void:
	_quit()
