extends Control

@onready var worlds: Array = [$"Levels/1", $"Levels/2", $"Levels/3", $"Levels/4", $"Levels/5", $"Levels/6", $"Levels/7"]
var current_world: int = 0
var move_tween: Tween
var auto_move_to_next: bool = false

#@onready var whalien = $Levels/Whalien


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.load_game()
	print("Level screen _ready called")
	print("Global.unlockedLevels: ", Global.unlockedLevels)

	Global.levels.clear()
	for i in range($Levels.get_child_count()):
		Global.levels.append(i+1)
	
		if Global.last_completed_level > 0:
			current_world = Global.last_completed_level - 1
			auto_move_to_next = true
		else:
			current_world = 0

	print("last_completed_level =", Global.last_completed_level)
	print("current_world =", current_world)
	print("target world node =", worlds[current_world].name)
	print("world position =", worlds[current_world].global_position)	
	update_level_states()
	
	tween_icon()

func update_level_states():
	print("Updating level states. Unlocked levels: ", Global.unlockedLevels)
	for level in $Levels.get_children():
		var level_num = str_to_var(level.name)
		if level_num <= Global.unlockedLevels + 1:
			level.disabled = false
			if level.has_node("Sprite2D"):
				level.get_node("Sprite2D").visible = false
			print("Enabled level: ", level.name)  
		else:
			level.disabled = true
			if level.has_node("Sprite2D"):
				level.get_node("Sprite2D").visible = true
			print("Disabled level: ", level.name)  

func _input(event):
	if move_tween and move_tween.is_running():
		return
		
	if event.is_action_pressed("ui_left") and current_world > 0:
		var target_level = str_to_var(worlds[current_world - 1].name)
		if target_level <= Global.unlockedLevels + 1:
			current_world -= 1
			tween_icon()
			
	if event.is_action_pressed("ui_right") and current_world < worlds.size()-1:
		var target_level = str_to_var(worlds[current_world + 1].name)
		if target_level <= Global.unlockedLevels + 1:
			current_world += 1
			tween_icon()
			
	if event.is_action_pressed("ui_accept"):
		var level_num = current_world + 1  
		if level_num <= Global.unlockedLevels + 1:
			var scene_path = "res://levels/level_" + str(level_num) + "/level_" + str(level_num) + ".tscn"
			print("Loading level: ", scene_path)
			get_tree().change_scene_to_file(scene_path)

func tween_icon():
	move_tween = get_tree().create_tween()
	move_tween.tween_property($CanvasLayer/PlayerIcon, "global_position", worlds[current_world].global_position + Vector2(0, -50), 0.5).set_trans(Tween.TRANS_SINE)
