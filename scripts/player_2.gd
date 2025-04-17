extends CharacterBody3D

var currSpeed : float = 5.0
const SPEED = 8.3
const RUN_SPEED = 10.4
const CROUCH_SPEED = 5.5

var mouseSens : float = 0.05

var canTalk : bool = false
var isTalking : bool = false
var isCrouching : bool = false
var canCrouch : bool = true

@onready var player: CharacterBody3D = $"."
@onready var body: Node3D = $body
@onready var camera: Camera3D = $body/Camera3D
@onready var crouchDelay: Timer = $crouchDelay
@onready var crouchRay: RayCast3D = $crouchRay

@onready var crouchCamera: Node3D = $crouchCamera
@onready var standCamera: Node3D = $standCamera
@onready var crouchingCollide: CollisionShape3D = $crouchingCollide
@onready var standingCollide: CollisionShape3D = $standingCollide

var hasBBGun : bool = false
var canShoot : bool = true
@onready var bbRay: RayCast3D = $body/Camera3D/bbRay
@onready var shootDelay: Timer = $shootDelay
@onready var bbgunShootSound: AudioStreamPlayer3D = $bbgunShootSound

@onready var animation: AnimationPlayer = $animation

func _ready() -> void:
	add_to_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and !animation.is_playing():
		rotate_y(deg_to_rad(-event.relative.x * mouseSens))
		body.rotate_x(deg_to_rad(-event.relative.y * mouseSens))
		body.rotation.x = clamp(body.rotation.x, deg_to_rad(-60), deg_to_rad(50))

func _process(delta: float) -> void:
	if PlayerGlobal.needsTeleport:
		position = PlayerGlobal.newPosition
		rotation.y = PlayerGlobal.newRotation
		PlayerGlobal.needsTeleport = false
	
	if !hasBBGun and ItemsGlobal.checkItem("bbgun"):
		hasBBGun = true
		bbRay.set_visible(true)
	
	if GamesGlobal.checkBeatGame("ufo") and !GamesGlobal.ufoChecked:
		ItemsGlobal.itemUpdateSet(true)
		GamesGlobal.ufoChecked = true
	if GamesGlobal.checkBeatGame("speedPitch") and !GamesGlobal.speedPitchChecked:
		ItemsGlobal.itemUpdateSet(true)
		GamesGlobal.speedPitchChecked = true
	if GamesGlobal.checkBeatGame("tower") and !GamesGlobal.towerChecked:
		ItemsGlobal.itemUpdateSet(true)
		GamesGlobal.towerChecked = true
	if GamesGlobal.checkBeatGame("range") and !GamesGlobal.rangeChecked:
		ItemsGlobal.itemUpdateSet(true)
		GamesGlobal.rangeChecked = true
	if GamesGlobal.checkBeatGame("skeeble") and !GamesGlobal.skeebleChecked:
		ItemsGlobal.itemUpdateSet(true)
		GamesGlobal.skeebleChecked = true
	
	if canTalk and Input.is_action_just_pressed("ui_accept") and !PlayerGlobal.inUI:
		PlayerGlobal.setIsTalking(true)
	
	if hasBBGun and Input.is_action_pressed("shoot") and canShoot and !PlayerGlobal.inUI:
		#bbgunShootSound.play(0.0)
		canShoot = false
		shootDelay.start()
		if bbRay.is_colliding():
			if bbRay.get_collider().has_method("score"):
				bbRay.get_collider().score()
			if bbRay.get_collider().has_method("fall"):
				bbRay.get_collider().fall()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Handle run
	if Input.is_action_pressed("run") and !isCrouching:
		currSpeed = RUN_SPEED
	else:
		currSpeed = SPEED

	if isCrouching and canCrouch:
		if Input.is_action_just_pressed("crouch") and !crouchRay.is_colliding():
			body.position.y = 1.142
			standingCollide.set_disabled(false)
			crouchingCollide.set_disabled(true)
			canCrouch = false
			isCrouching = false
			crouchDelay.start()

	if !isCrouching and canCrouch:
		if Input.is_action_just_pressed("crouch"):
			body.position.y = 0.442
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
	if direction:
		velocity.x = direction.x * currSpeed
		velocity.z = direction.z * currSpeed
	else:
		velocity.x = move_toward(velocity.x, 0, currSpeed)
		velocity.z = move_toward(velocity.z, 0, currSpeed)

	if !PlayerGlobal.isTalking and !animation.is_playing():
		move_and_slide()

func camMove() -> void:
	if !animation.is_playing():
		animation.play("finaleCamera")

func _on_crouch_delay_timeout() -> void:
	canCrouch = true

func _on_shoot_delay_timeout() -> void:
	canShoot = true
