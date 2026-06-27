extends CanvasLayer

var coinsCollected = 0
var maxCoin = 10 #13
var player_in_chest_area = false  # Flag to track if the player is in the chest area

@onready var timer = $Timer

func _ready() -> void:
	$Label.text = "Treasures collected: " + str(coinsCollected) + "/" + str(maxCoin)
	timer.start()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	# Check for game over or success conditions
	if timer.time_left <= 0.0 and coinsCollected != maxCoin:  
		get_tree().change_scene_to_file("res://canvases/game_over3.tscn")
	elif coinsCollected == maxCoin:
		get_tree().change_scene_to_file("res://canvases/success_3.tscn")
	
	# Check if the player is inside the chest area and presses the collect button
	if player_in_chest_area and Input.is_action_just_pressed("collect"):
		coinsCollected += 3
		$Label.text = "Treasures collected: " + str(coinsCollected) + "/" + str(maxCoin)

func _on_coin_body_entered(_body: Node3D) -> void:
	coinsCollected += 1  
	$Label.text = "Treasures collected: " + str(coinsCollected) + "/" + str(maxCoin)

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Doggo":  # Ensure it's the player entering the chest's area
		player_in_chest_area = true  

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Doggo":
		player_in_chest_area = false  # Reset when the player leaves
