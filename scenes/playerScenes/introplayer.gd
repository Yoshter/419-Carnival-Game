extends CharacterBody3D

var currSpeed : float = 5.0
const SPEED = 8.3
const RUN_SPEED = 10.4
const CROUCH_SPEED = 5.5

var isCrouching : bool = false
var canCrouch : bool = true


var mouseSens : float = 0.05
var mouseCaptured : bool = false

var hasFloatedIn : bool = false
var canMove : bool = false

@onready var body: Node3D = $body
@onready var playerAnimations: AnimationPlayer = $playerAnimations
@onready var crouchRay: RayCast3D = $crouchRay
@onready var standingCollide: CollisionShape3D = $standingCollide
@onready var crouchingCollide: CollisionShape3D = $crouchingCollide
@onready var crouchDelay: Timer = $crouchDelay

func _ready() -> void:
	add_to_group("player")
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and !playerAnimations.is_playing() and canMove and !PlayerGlobal.inUI  and !PlayerGlobal.isPaused:
		rotate_y(deg_to_rad(-event.relative.x * mouseSens))
		body.rotate_x(deg_to_rad(-event.relative.y * mouseSens))
		body.rotation.x = clamp(body.rotation.x, deg_to_rad(-60), deg_to_rad(50))

func _process(delta: float) -> void:
	if canMove and !mouseCaptured and !PlayerGlobal.inUI:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		mouseCaptured = true
	
	if PlayerGlobal.inUI == true:
		playerAnimations.stop()
	
	if !PlayerGlobal.inUI and !hasFloatedIn and !playerAnimations.is_playing() and PlayerGlobal.mustFloat:
		playerAnimations.play("floatIn")
		hasFloatedIn = true
		PlayerGlobal.mustFloat = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if canMove and not is_on_floor():
		velocity += get_gravity() * delta

	#Handle run
	if canMove and Input.is_action_pressed("run") and !isCrouching:
		currSpeed = RUN_SPEED
	else:
		currSpeed = SPEED

	if canMove and isCrouching and canCrouch:
		if Input.is_action_just_pressed("crouch") and !crouchRay.is_colliding():
			body.position.y = 0.0
			standingCollide.set_disabled(false)
			crouchingCollide.set_disabled(true)
			canCrouch = false
			isCrouching = false
			crouchDelay.start()

	if canMove and !isCrouching and canCrouch:
		if Input.is_action_just_pressed("crouch"):
			body.position.y = -0.5
			currSpeed = CROUCH_SPEED
			standingCollide.set_disabled(true)
			crouchingCollide.set_disabled(false)
			canCrouch = false
			isCrouching = true
			crouchDelay.start()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if canMove and direction:
		velocity.x = direction.x * currSpeed
		velocity.z = direction.z * currSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, currSpeed)
		velocity.z = move_toward(velocity.z, 0, currSpeed)

	if !PlayerGlobal.isTalking and !playerAnimations.is_playing():
		move_and_slide()

func _on_crouch_delay_timeout() -> void:
	canCrouch = true

func _on_player_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == "floatIn":
		PlayerGlobal.canMove = true
		canMove = PlayerGlobal.canMove
