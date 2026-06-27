extends Node3D

@onready var animationPlayer = $AnimationPlayer
@onready var label = $Label3D

var opened = false

func _ready() -> void:
	label.visible = true

func _process(_delta: float) -> void:
	if opened:
		return
	var score = get_tree().get_root().get_node_or_null("Node3D/CanvasLayer")
	if score == null:
		return
	label.text = "collect all treasures to open"
	if score._all_collected():
		_open_chest()

func _open_chest() -> void:
	opened = true
	label.visible = false
	animationPlayer.play("open")
	await animationPlayer.animation_finished
	get_tree().change_scene_to_file("res://canvases/success_3.tscn")
