extends CanvasLayer

var coinsCollected = 0
var keysCollected = 0
const keysRequired = 7
const coinsRequired = 25
var player_in_chest_area = false
var danger_active := false
var danger_elapsed := 0.0
const DANGER_DURATION = 5.0

@onready var timer = $Timer

func _ready() -> void:
	_update_label()
	timer.start()
	
func _all_collected() -> bool:
	return coinsCollected == coinsRequired and keysCollected == keysRequired

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	if timer.time_left <= 0.0 and keysCollected < keysRequired and coinsCollected < coinsRequired:
		get_tree().change_scene_to_file("res://canvases/game_over3.tscn")
	if _all_collected and player_in_chest_area and Input.is_action_just_pressed("collect"):
		get_tree().change_scene_to_file("res://canvases/success_3.tscn")
	if danger_active and $DangerOverlay:
		danger_elapsed += delta
		var intensity = danger_elapsed / DANGER_DURATION
		var speed = min(2.0 + intensity * 1.5, 3.0)
		var pulse = abs(sin(danger_elapsed * speed))
		$DangerOverlay.color.a = pulse * intensity * 0.4

func _on_coin_body_entered(_body: Node3D) -> void:
	coinsCollected += 1
	_update_label()

func _on_key_collected() -> void:
	keysCollected += 1
	_update_label()
	_update_chest_glow()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == "Doggo":
		player_in_chest_area = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == "Doggo":
		player_in_chest_area = false

func _update_label() -> void:
	$Label.text = "Keys: " + str(keysCollected) + "/" + str(keysRequired) + "   Coins: " + str(coinsCollected) + "/" + str(coinsRequired)

func _update_chest_glow() -> void:
	var light = get_tree().get_root().get_node_or_null("Node3D/chest/PointLight3D")
	if light:
		light.light_energy = (float(keysCollected) / float(keysRequired)) * 6.0
		
func start_danger_flash() -> void:
	danger_active = true
	danger_elapsed = 0.0
	$DangerOverlay.visible = true

func stop_danger_flash() -> void:
	danger_active = false
	danger_elapsed = 0.0
	$DangerOverlay.visible = false
	if $DangerOverlay:
		$DangerOverlay.color.a = 0.0
		
