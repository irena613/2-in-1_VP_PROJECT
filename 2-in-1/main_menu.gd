extends Control

func _get_base_dir() -> String:
	if OS.has_feature("editor"):
		return ProjectSettings.globalize_path("res://")
	return OS.get_executable_path().get_base_dir()

func _on_game1_pressed() -> void:
	var path = _get_base_dir().path_join("The Forgo_ten Melody.exe")
	OS.create_process(path, [])
	get_tree().quit()

func _on_game2_pressed() -> void:
	var path = _get_base_dir().path_join("Treasure-Hunting-Hound.exe")
	OS.create_process(path, [])
	get_tree().quit()
