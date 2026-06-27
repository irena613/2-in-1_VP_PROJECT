extends Node3D

const DECO_SCENES = [
	preload("res://static scenes/ground1.tscn"),
	preload("res://static scenes/tree-flower-rock2.tscn")
]

const SECTION_COUNT = 10
const MIN_SPACING   = 40.0   # min distance between decoration clusters

# Points to keep clear of decorations
const EXCLUSIONS = [
	Vector3(0,    0, 0),           
	Vector3(88.5, 0, -63.3),      
	Vector3(100,  0, -81.4),     
]
const EXCLUSION_RADIUS = 30.0

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var placed: Array[Vector3] = []
	var attempts := 0

	while placed.size() < SECTION_COUNT and attempts < 500:
		attempts += 1
		var x = rng.randf_range(-100.0, 105.0)
		var z = rng.randf_range(-93.0, 111.0)
		var pos = Vector3(x, 0, z)

		if _too_close(pos, placed) or _in_exclusion(pos):
			continue

		var deco = DECO_SCENES[rng.randi() % DECO_SCENES.size()].instantiate()
		deco.position = pos
		add_child(deco)
		placed.append(pos)

func _too_close(pos: Vector3, others: Array[Vector3]) -> bool:
	for p in others:
		if pos.distance_to(p) < MIN_SPACING:
			return true
	return false

func _in_exclusion(pos: Vector3) -> bool:
	for e in EXCLUSIONS:
		if Vector2(pos.x, pos.z).distance_to(Vector2(e.x, e.z)) < EXCLUSION_RADIUS:
			return true
	return false
