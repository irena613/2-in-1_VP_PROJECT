extends "res://level_base.gd"

@onready var timer = $CanvasLayer/Timer2/Timer

func _ready() -> void:
	level_number = 7
	super._ready()
	
	var note_number = 79
	for note in $Notes.get_children():
		note.note_number = note_number
		note.note_collected.connect(_on_note_collected)
		note_number += 1
	
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	return_to_level_screen()

func _on_border_2_body_entered(body: Node2D) -> void:
	if body == $Whalien:
		return_to_level_screen()

func _on_border_3_body_entered(body: Node2D) -> void:
	if body == $Whalien:
		return_to_level_screen()

func _on_border_4_body_entered(body: Node2D) -> void:
	if body == $Whalien:
		return_to_level_screen()

func _on_portal_body_entered(body: Node2D) -> void:
	if body == $Whalien and Global.notes_collected == 13:
		Global.notes_collected = 0
		Global.unlockedLevels = max(Global.unlockedLevels, level_number)
		Global.save_game()
		var anim_sprite = $Portal/AnimatedSprite2D
		anim_sprite.play("open")
		await anim_sprite.animation_finished
		get_tree().change_scene_to_file("res://game win/game_win.tscn")
	else:
		Global.unlockedLevels = 0
		
func _on_note_collected():
	$CanvasLayer/NotesLable.text = "Notes: " + str(Global.notes_collected)  + "/13"
	print_debug("Notes: " + str(Global.notes_collected))


func _on_border_body_entered(body: Node2D) -> void:
	if body == $Whalien:
		Global.notes_collected = 0
		get_tree().change_scene_to_file("res://menu/main_menu.tscn")
