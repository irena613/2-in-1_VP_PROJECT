extends Node3D

@onready var animationPlayer = $AnimationPlayer
@onready var label = $Label3D

var opened = false
var inRange = false
var once = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#rotate_y(0.01)
	if once:
		if Input.is_action_just_pressed("opened") && !opened  && inRange:
			opened = true
			label.visible = false
			animationPlayer.play("open")
			$Label3D2.visible = true
		if Input.is_action_just_pressed("collect") && opened && inRange:
			$chest_gold.visible=false
			$Chest.visible=true
			$Label3D2.visible = false
			$chestSound.play()
			once = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	if "Doggo" in body.name:
		label.visible = true
		inRange =true
	 # Replace with function body.


func _on_area_3d_body_exited(body: Node3D) -> void:
	if "Doggo" in body.name:
		label.visible = false
		inRange =false
	pass # Replace with function body.
