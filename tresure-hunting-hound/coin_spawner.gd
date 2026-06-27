extends Node3D

const COIN_SCENE = preload("res://coin.tscn")
const COIN_COUNT = 25
const SPAWN_Y    = 2.0


const MAP_MIN = Vector2(-105.0, -98.0)
const MAP_MAX = Vector2( 110.0, 116.0)

# Excluding zone:  biglake is at (99.95, -81.4)
const EXCLUSIONS = [
	[100.0, -81.4, 35.0],
]

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var spawned  := 0
	var attempts := 0
	while spawned < COIN_COUNT and attempts < 500:
		attempts += 1
		var x = rng.randf_range(MAP_MIN.x, MAP_MAX.x)
		var z = rng.randf_range(MAP_MIN.y, MAP_MAX.y)
		if _in_exclusion(x, z):
			continue
		var coin = COIN_SCENE.instantiate()
		coin.position = Vector3(x, SPAWN_Y, z)
		print(coin.position)
		add_child(coin)
		var score = get_parent().get_node("CanvasLayer")
		coin.body_entered.connect(score._on_coin_body_entered)
		spawned += 1

func _in_exclusion(x: float, z: float) -> bool:
	for e in EXCLUSIONS:
		var dist = Vector2(x, z).distance_to(Vector2(e[0], e[1]))
		if dist < e[2]:
			return true
	return false
