extends Node3D

const KEY_SCENE = preload("res://key.tscn")
const KEY_COUNT = 7
const SPAWN_Y = 2.0
const MIN_SPACING = 35.0

const MAP_MIN = Vector2(-105.0, -98.0)
const MAP_MAX = Vector2(110.0, 116.0)

const EXCLUSIONS = [
	[100.0, -81.4, 35.0],
	[88.5,  -63.3, 15.0],
	[0.0,   0.0,   15.0],
]

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var placed: Array[Vector3] = []
	var attempts := 0
	while placed.size() < KEY_COUNT and attempts < 500:
		attempts += 1
		var x = rng.randf_range(MAP_MIN.x, MAP_MAX.x)
		var z = rng.randf_range(MAP_MIN.y, MAP_MAX.y)
		var pos = Vector3(x, SPAWN_Y, z)
		if _in_exclusion(x, z) or _too_close(pos, placed):
			continue
		var key = KEY_SCENE.instantiate()
		key.position = pos
		add_child(key)
		placed.append(pos)

func _in_exclusion(x: float, z: float) -> bool:
	for e in EXCLUSIONS:
		if Vector2(x, z).distance_to(Vector2(e[0], e[1])) < e[2]:
			return true
	return false

func _too_close(pos: Vector3, others: Array[Vector3]) -> bool:
	for p in others:
		if pos.distance_to(p) < MIN_SPACING:
			return true
	return false
	
func respawn_key() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var attempts := 0
	while attempts < 500:
		attempts += 1
		var x = rng.randf_range(MAP_MIN.x, MAP_MAX.x)
		var z = rng.randf_range(MAP_MIN.y, MAP_MAX.y)
		if _in_exclusion(x, z):
			continue
		var key = KEY_SCENE.instantiate()
		key.position = Vector3(x, SPAWN_Y, z)
		add_child(key)
		break
