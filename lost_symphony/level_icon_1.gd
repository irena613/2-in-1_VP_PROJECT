extends Control

@export var level_index = 1
@export var disabled : bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = "Level " + str(level_index)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
