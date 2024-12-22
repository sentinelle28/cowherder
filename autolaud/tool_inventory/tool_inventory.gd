extends CanvasLayer

var current_tool:int = 0
signal change_tool
@onready var max_tool:int = len(texture_array)
@export var texture_array:Array[Texture2D] = []
func _ready() -> void:

	_update_tool_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_input_change_tool()

func _input_change_tool()->void:
	if Input.is_action_just_pressed("next_tool"):
		_change_tool(1)
		
	if Input.is_action_just_pressed("previous_tool"):
		_change_tool(-1)
		
func _change_tool(value:int)->void:
	current_tool += value
	if current_tool < 0:
		current_tool = max_tool - 1
	elif current_tool > max_tool - 1:
		current_tool = 0
	_update_tool_texture()
	emit_signal("change_tool")

func get_current_tool()->int:
	return current_tool

func _update_tool_texture()->void:
	$HBoxContainer/tool.texture = texture_array[current_tool]
	
func _reset_tool()->void:
	current_tool = 0
	_update_tool_texture()
