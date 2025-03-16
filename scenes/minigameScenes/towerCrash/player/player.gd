extends CharacterBody2D

@onready var animatedSprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var spinbox: CollisionShape2D = $spinArea/spinbox
@onready var spinTimer: Timer = $timerBox/SpinTimer
@onready var coyoteTimer : Timer = $timerBox/CoyoteTimer
@onready var jumpBufferTimer: Timer = $timerBox/JumpBufferTimer
@onready var boostTimer: Timer = $timerBox/boostTimer
@onready var jumpAudio: AudioStreamPlayer2D = $audioBox/jumpAudio
@onready var spinAudio: AudioStreamPlayer2D = $audioBox/spinAudio
@onready var fallAudio: AudioStreamPlayer2D = $audioBox/fallAudio

var speed : float = 220.0

var WALK_SPEED : float = 220.0
var RUN_SPEED : float = 340.0

var JUMP_VELOCITY : float = -325.0
var runTimer : float = 0.0
var fallTime : float = 1.1
var jumpCounter = 0

var gravity = 100.0
var fallSpeed = 23.5
var timeInAir = 0.0
var isJumping : bool = false
var jumpBuffered : bool = false
var isSpinning : bool = false
var isFalling : bool = false

var isSpeedBoosted : bool = false
var isJumpBoosted : bool = false

#var canMove = Global.playerCanMove

func _ready() -> void:
	add_to_group("player")

func _process(_delta: float) -> void:
	
	if isSpeedBoosted:
		WALK_SPEED = 440.0
		RUN_SPEED = 680.0
	
	if !isSpeedBoosted:
		WALK_SPEED = 220.0
		RUN_SPEED = 340.0
	
	print(isSpeedBoosted)
	
	if isJumpBoosted:
		JUMP_VELOCITY = -450.0
	else:
		JUMP_VELOCITY = -325.0
	
	if timeInAir >= fallTime and !isFalling:
		isFalling = true
		print("falling")
		fallAudio.play(0)
	
	if Input.is_action_pressed("run"):
		speed = RUN_SPEED
	else:
		speed = WALK_SPEED
	
	if Input.is_action_just_pressed("spin"):
		spin()
	
	if Input.is_action_just_pressed("right"):
		animatedSprite.scale.x = .15
	if Input.is_action_just_pressed("left"):
		animatedSprite.scale.x = -.15
	
	if Input.is_action_just_pressed("right") and !isJumping and !isSpinning:
		animatedSprite.play("walk")
		
	if Input.is_action_just_pressed("left") and !isJumping and !isSpinning:
		animatedSprite.play("walk")

func _physics_process(delta: float) -> void:
	
	velocity.y += (gravity * timeInAir * 1.4 * fallSpeed * delta)
	
	# Add the gravity.
	if not is_on_floor():
		timeInAir += delta
	else:
		timeInAir = 0.0
		isJumping = false
		isFalling = false
		jumpCounter = 0
		fallAudio.stop()

	if is_on_floor() and jumpBuffered:
		animatedSprite.stop()
		jump()
		jumpBuffered = false

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if (is_on_floor() || !coyoteTimer.is_stopped()) && jumpCounter < 1 && !isSpinning:
			jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	if was_on_floor and !is_on_floor():
		coyoteTimer.start()
	
	if !is_on_floor() and Input.is_action_pressed("jump"):
		jumpBufferTimer.start()
		jumpBuffered = true

func halfjump()-> void:
	jumpCounter += 1
	velocity.y = (JUMP_VELOCITY / 2)
	animatedSprite.play("jump")
	jumpAudio.play(0)
	isJumping = true

func jump() -> void:
	jumpCounter += 1
	velocity.y = JUMP_VELOCITY
	animatedSprite.play("jump")
	jumpAudio.play(0)
	isJumping = true

func bounce() -> void:
	position.x += 450

func spin() -> void:
	isSpinning = true
	spinbox.set_disabled(false)
	animatedSprite.play("spin")
	spinAudio.play(0)
	spinTimer.start()

func die() -> void:
	pass
	#Global.enemiesKilled = 0
	#print(Global.currLevel)
	#get_tree().change_scene_to_file.call_deferred(Global.currLevel)

func _on_jump_buffer_timer_timeout() -> void:
	jumpBuffered = false

func _on_spin_timer_timeout() -> void:
	isSpinning = false
	spinbox.set_disabled(true)
	animatedSprite.play("idle")

func _on_spin_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("crate"):
		body._break()

func _on_boost_timer_timeout() -> void:
	isSpeedBoosted = false
	print("no more boost")
