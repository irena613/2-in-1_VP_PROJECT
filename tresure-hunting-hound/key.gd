extends Node3D

var coinsCollected = 0
var keysCollected = 0
const keysRequired = 7
var player_in_chest_area = false
@onready var timer = $Timer
func _process(_delta: float) -> void:
	rotate_y(0.02)
	
func _update_label() -> void:
	$Label.text = "Keys: " + str(keysCollected) + "/" + str(keysRequired) + "   Coins: " + str(coinsCollected)

func _on_collect_zone_body_entered(body: Node3D) -> void:
	if body.name == "Doggo":
		$keysound.play()
		$MeshInstance3D.queue_free()
		var score = get_tree().get_root().get_node("Node3D/CanvasLayer")

func _on_danger_zone_body_entered(body: Node3D) -> void:
	print("entered danger zone: ", body.name)
	if body.name == "Doggo":
		$DangerTimer.start()

func _on_danger_zone_body_exited(body: Node3D) -> void:
	if body.name == "Doggo":
		$DangerTimer.stop()

func _on_danger_timer_timeout() -> void:
	var score = get_tree().get_root().get_node("Node3D/CanvasLayer")
	get_tree().get_root().get_node("Node3D/KeySpawner").respawn_key()
	queue_free()
