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

var isCharging = false
var isCharged = true
var isSwinging = false
var chargeNum : float = 0.00
var saveChargeNum : float = 0.00

@onready var weaponDelay: Timer = $weaponDelay

@onready var animation: AnimationPlayer = $animation
@onready var fallTimer: Timer = $fallTimer
var fallCount : int = 0

func _ready() -> void:
	add_to_group("player")
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and !animation.is_playing() and !PlayerGlobal.isPaused:
		rotate_y(deg_to_rad(-event.relative.x * mouseSens))
		body.rotate_x(deg_to_rad(-event.relative.y * mouseSens))
		body.rotation.x = clamp(body.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		
func _process(delta: float) -> void:
	print("chargenum: " + str(WeaponsGlobal.isCharging))
	if WeaponsGlobal.isCharging:
		chargeNum += delta * 5
		print("chargeNum: " + str(WeaponsGlobal.saveChargeNum))
	if !WeaponsGlobal.isCharging and !WeaponsGlobal.isCharged and !WeaponsGlobal.isSwinging:
		chargeNum = 0.00
	WeaponsGlobal.saveChargeNum = chargeNum
	
	if PlayerGlobal.needsTeleport:
		position = PlayerGlobal.newPosition
		rotation.y = PlayerGlobal.newRotation
		PlayerGlobal.needsTeleport = false
	
	if !hasBBGun and ItemsGlobal.checkItem("bbgun"):
		bbRay.set_visible(true)
		hasBBGun = true
	
	#fists
	if Input.is_action_just_pressed("weapon01"):
		canShoot = false
		weaponDelay.wait_time = 0.8
		weaponDelay.start()
		WeaponsGlobal.currentWeapon = "fists"
		bbRay.enabled = false
	#pipe
	if Input.is_action_just_pressed("weapon02") and ItemsGlobal.checkItem("pipe"):
		weaponDelay.wait_time = 1.2
		weaponDelay.start()
		WeaponsGlobal.currentWeapon = "pipe"
		bbRay.enabled = false
	#shotgun
	if Input.is_action_just_pressed("weapon03") and hasBBGun:
		weaponDelay.wait_time = 0.8
		weaponDelay.start()
		WeaponsGlobal.currentWeapon = "bbgun"
		bbRay.enabled = true
	
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
	
	if hasBBGun and Input.is_action_pressed("shoot") and canShoot and !PlayerGlobal.inUI and WeaponsGlobal.getCurrentWeapon() == "bbgun":
		#bbgunShootSound.play(0.0)
		canShoot = false
		shootDelay.start()
		if bbRay.is_colliding():
			if bbRay.get_collider().has_method("score"):
				bbRay.get_collider().score()
			if bbRay.get_collider().has_method("fall"):
				bbRay.get_collider().fall()
	
	if !WeaponsGlobal.isCharging and Input.is_action_pressed("shoot") and WeaponsGlobal.currentWeapon == "pipe":
		WeaponsGlobal.isCharging = true
		WeaponsGlobal.isSwinging = false
	if WeaponsGlobal.isCharged and Input.is_action_just_released("shoot") and WeaponsGlobal.currentWeapon == "pipe":
		WeaponsGlobal.isCharging = false
		WeaponsGlobal.isSwinging = true
		chargeNum = 0.00
	
	if WeaponsGlobal.getCurrentWeapon() == "pipe" and canShoot and !PlayerGlobal.inUI:
		canShoot = false
		weaponDelay.start()
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Handle run
	if Input.is_action_pressed("run") and !isCrouching:
		currSpeed = RUN_SPEED
	else:
		currSpeed = SPEED

	if isCrouching and canCrouch and !PlayerGlobal.isTalking:
		if Input.is_action_just_pressed("crouch") and !crouchRay.is_colliding():
			body.position.y = 1.142
			standingCollide.set_disabled(false)
			crouchingCollide.set_disabled(true)
			canCrouch = false
			isCrouching = false
			crouchDelay.start()

	if !isCrouching and canCrouch and !PlayerGlobal.isTalking:
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

func _on_fall_timer_timeout() -> void:
	fallCount += 1
	if fallCount < 29:
		fallTimer.start()
	if !animation.is_playing() and fallCount == 25:
		animation.play("falling")
		#fallTimer.start()
	if fallCount == 26:
		PlayerGlobal.isFalling = true
		#fallTimer.start()
	if fallCount == 29:
		PlayerGlobal.isFalling = false
		get_tree().change_scene_to_file("res://scenes/bossScenes/craneBossScenes/crane_boss_environment.tscn")

func _on_weapon_delay_timeout() -> void:
	canShoot = true
