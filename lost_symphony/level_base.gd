extends Node2D

var level_number: int = 1

func _ready() -> void:
	Global.load_game()
	print("Level screen _ready called")
	print("Global.unlockedLevels: ", Global.unlockedLevels)
	if has_node("Notes"):
		for note in $Notes.get_children():
			note.note_collected.connect(_on_note_collected)
		randomize_note_positions()

	update_notes_display()

func randomize_note_positions() -> void:
	if not has_node("TileMapLayer"):
		return
	var tilemap := $TileMapLayer
	var tile_h := float(tilemap.tile_set.tile_size.y)
	var notes := $Notes.get_children()

	# Find every tile that is solid with open space above it (a walkable surface)
	var candidates: Array = []
	for cell in tilemap.get_used_cells():
		var td = tilemap.get_cell_tile_data(cell)
		if td == null or td.get_collision_polygons_count(0) == 0:
			continue
		var above_td = tilemap.get_cell_tile_data(Vector2i(cell.x, cell.y - 1))
		if above_td != null and above_td.get_collision_polygons_count(0) > 0:
			continue
		# Convert tile centre → world → level-local space, then lift above surface
		var pos: Vector2 = to_local(tilemap.to_global(tilemap.map_to_local(cell)))
		pos.y -= tile_h
		candidates.append(pos)

	candidates.shuffle()

	# Pick well-spaced positions from the candidates
	var chosen: Array = []
	var min_dist := 80.0
	for pos in candidates:
		var ok := true
		for c in chosen:
			if (pos as Vector2).distance_to(c as Vector2) < min_dist:
				ok = false
				break
		if ok:
			chosen.append(pos)
		if chosen.size() == notes.size():
			break

	# Fallback: fill any remaining slots ignoring spacing
	for pos in candidates:
		if chosen.size() == notes.size():
			break
		if pos not in chosen:
			chosen.append(pos)

	for i in min(chosen.size(), notes.size()):
		notes[i].position = chosen[i]
		notes[i].start_position = chosen[i]

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
