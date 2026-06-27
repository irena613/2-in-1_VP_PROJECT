extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	Global.reset_progress()
	get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")


func _on_continue_pressed() -> void:
	Global.load_game()
	get_tree().change_scene_to_file("res://level_screen.tscn")


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://controls.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()
	
