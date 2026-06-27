extends Node

var notes_collected = 0
var levels = []
var unlockedLevels = 0 
var last_completed_level = 0
var current_level = 1  
const SAVE_FILE = "user://savegame.save"
var current_sound_sequence = 1 
 
func _ready() -> void:
	print("Global _ready called")
	load_game()

func save_game():
	print("Attempting to save game...")
	var save_dict = {
		"notes_collected": notes_collected,
		"unlockedLevels": unlockedLevels,
		"last_completed_level": last_completed_level,
		"current_sound_sequence": current_sound_sequence
	}
	print("Save data: ", save_dict)
	
	var save_file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	if save_file:
		save_file.store_var(save_dict)
		print("Game saved successfully! Unlocked levels: ", unlockedLevels)
	else:
		print("Error: Could not open save file for writing!")

func load_game():
	print("Attempting to load game...")
	if FileAccess.file_exists(SAVE_FILE):
		var save_file = FileAccess.open(SAVE_FILE, FileAccess.READ)
		if save_file:
			var save_dict = save_file.get_var()
			if save_dict != null:
				notes_collected = save_dict.get("notes_collected", 0)
				unlockedLevels = save_dict.get("unlockedLevels", 0)
				last_completed_level = save_dict.get("last_completed_level", 0)
				current_sound_sequence = save_dict.get("current_sound_sequence", 1)
				print("Game loaded successfully! Unlocked levels: ", unlockedLevels)
			else:
				print("Error: Invalid save data!")
				reset_progress()
		else:
			print("Error: Could not open save file for reading!")
			reset_progress()
	else:
		print("No save file found. Starting new game.")
		reset_progress()

func reset_progress():
	print("Resetting progress...")
	notes_collected = 0
	unlockedLevels = 1
	last_completed_level = 0
	current_sound_sequence = 1
	if FileAccess.file_exists(SAVE_FILE):
		var dir = DirAccess.open("user://")
		if dir:
			dir.remove("savegame.save")
			print("Save file deleted")
		else:
			print("Error: Could not access save directory!")
	print("Progress reset complete. Unlocked levels: ", unlockedLevels)

func complete_level(level_number: int):
	print("Completing level: ", level_number)
	unlockedLevels = max(unlockedLevels, level_number)
	last_completed_level = level_number
	save_game()

func quit_level(level_number: int):
	print("Quitting level: ", level_number)
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
	save_game()

func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		print("Returning to main menu, saving game...")
		save_game()
		get_tree().change_scene_to_file("res://menu/main_menu.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
