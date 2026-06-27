extends Node

@onready var label = $Label 
@onready var timer = $Timer

func _ready() -> void:
	timer.start() 

# Function to calculate time left
func _time_left_to_live():
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]  

func _process(delta: float) -> void:
	var time_values = _time_left_to_live()  # Get the minute and second values
	label.text = "%02d:%02d" % [time_values[0], time_values[1]]
	
