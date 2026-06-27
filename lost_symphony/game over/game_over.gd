extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"): 
		_on_continue_pressed()

func _on_continue_pressed() -> void:
	var level_path = "res://levels/level_"+ str(Global.current_level) +"/level_" + str(Global.current_level) + ".tscn"
	get_tree().change_scene_to_file(level_path)

func _on_quit_game_pressed() -> void:
	get_tree().quit()
	

func _on_return_to_main_menu_pressed() -> void:
	Global.load_game()
	get_tree().change_scene_to_file("res://level_screen.tscn")
