extends CanvasModulate

const InGameToRealHour:float = (2*PI)/24

@export var gradient:GradientTexture1D
@export var TimeSpeed:float = 1
@export var night_threshold:float = 0.4
@onready var true_time_speed:float= 1/TimeSpeed

signal dawn

var is_current_night
var current_day:int = 0
var time:float = 0

var can_start:bool = false

func _ready() -> void:
	time = InGameToRealHour * 10

func _caculate_time()->float:
	return (cos(time+PI/2)+1.0)/2.0


func is_night()->bool:
	var value:float = _caculate_time()
	return value < night_threshold

func _process(delta: float) -> void:
	if can_start:
		time += delta * InGameToRealHour * true_time_speed
		var value:float = _caculate_time()
		color = gradient.gradient.sample(value)
		_aux_dawn()

func _aux_dawn()->void:
	if is_night():
		is_current_night = true
			
	if is_current_night and not is_night():
		is_current_night = false
		_detect_dawn()

func _stop()->void:
	color = gradient.gradient.sample(1)
	can_start = false
	
func _start()->void:
	can_start = true

func _detect_dawn()->void:
	emit_signal("dawn")
