extends CharacterBody3D

@onready var camera_mount = $camera_mount

var SPEED = 7.0
const JUMP_VELOCITY = 7

@export var sens_horizontal = 0.2
@export var sens_vertical = 0.2

var walking_speed = 7.0
var running_speed = 13.0

@onready var animationPlayer = $dog3/AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var doggo =$dog3

var running = false

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * sens_horizontal))
		#doggo.rotate_y(event.relative.x * sens_horizontal)
		camera_mount.rotate_x(deg_to_rad(-event.relative.y*sens_vertical))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	# Add the gravity.
	
	if Input.is_action_pressed("run"):
		SPEED = running_speed
		running=true
	else:
		SPEED = walking_speed
		running=false
	
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if animationPlayer.current_animation != "jump":
				animationPlayer.play("jump")
				velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if running:
			if animationPlayer.current_animation != "run":
				animationPlayer.play("run")
		else:
			if animationPlayer.current_animation != "walk":
				animationPlayer.play("walk")
		
		#doggo.look_at(position+direction)
		doggo.look_at(global_transform.origin + direction)
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		if animationPlayer.current_animation != "iddle":
			animationPlayer.play("iddle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()  
