extends "res://notes/note_base.gd"


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Whalien":
		Global.notes_collected += 1
		print_debug("note type 4 collected")
		queue_free()
	
