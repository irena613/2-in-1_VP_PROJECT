extends Control


@onready var message = $Message 

func _ready() -> void:
	$Confetti/AnimationPlayer.play("rotate")
	$Confetti2/AnimationPlayer.play("rotate")
	

func _on_new_game_pressed() -> void:
	Global.reset_progress()
	get_tree().change_scene_to_file("res://levels/level_1/level_1.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_return_to_main_menu_pressed() -> void:
	Global.reset_progress()
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
