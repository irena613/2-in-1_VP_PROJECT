extends "res://notes/note_base.gd"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Whalien":
		Global.notes_collected += 1
		note_collected.emit()
		print_debug("note type 1 collected")
		queue_free()
	
