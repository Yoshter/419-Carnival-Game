extends CharacterBody3D

var currSpeed : float = 5.0
const SPEED = 5.0
const RUN_SPEED = 6.0

var mouseSens : float = 0.05

@onready var player: CharacterBody3D = $"."
@onready var body: Node3D = $body
@onready var camera: Camera3D = $body/Camera3D

func _ready() -> void:
	add_to_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouseSens))
		body.rotate_x(deg_to_rad(-event.relative.y * mouseSens))
		body.rotation.x = clamp(body.rotation.x, deg_to_rad(-60), deg_to_rad(50))

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Handle run
	if Input.is_action_pressed("run"):
		currSpeed = RUN_SPEED
	else:
		currSpeed = SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * currSpeed
		velocity.z = direction.z * currSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, currSpeed)
		velocity.z = move_toward(velocity.z, 0, currSpeed)

	move_and_slide()
