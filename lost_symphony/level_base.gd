extends Node2D

var level_number: int = 1 

func _ready() -> void:
	Global.load_game()
	print("Level screen _ready called")
	print("Global.unlockedLevels: ", Global.unlockedLevels)
	if has_node("Notes"):
		for note in $Notes.get_children():
			note.note_collected.connect(_on_note_collected)
	
	update_notes_display()

func update_notes_display():
	if has_node("CanvasLayer/NotesLable"):
		$CanvasLayer/NotesLable.text = "Notes: " + str(Global.notes_collected) + "/13"

func _on_note_collected():
	Global.notes_collected += 1
	update_notes_display()
	print("Notes collected: ", Global.notes_collected)

func complete_level():
	print("Completing level ", level_number)
	Global.unlockedLevels = max(Global.unlockedLevels, level_number)
	Global.save_game()
	
	var anim_sprite = $Portal/AnimatedSprite2D
	if anim_sprite:
		anim_sprite.play("open")
		await anim_sprite.animation_finished
	get_tree().change_scene_to_file("res://level_screen.tscn")

func return_to_level_screen():
	print("Game over on level ", level_number)
	Global.current_level = level_number
	Global.notes_collected = 0
	get_tree().change_scene_to_file("res://game over/game_over.tscn")

func _on_portal_body_entered(body: Node2D) -> void:
	if body == $Whalien:
		complete_level()

func _on_border_body_entered(body: Node2D) -> void:
	if body == $Whalien:
		return_to_level_screen() 
