extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

var isDead : bool = false

@onready var beam: Node2D = $beam

@onready var beamSound: AudioStreamPlayer = $beamSound
@onready var deathSound: AudioStreamPlayer = $deathSound
@onready var deathTimer: Timer = $deathTimer

func _ready() -> void:
	add_to_group("ufoPlayer")

func _physics_process(delta: float) -> void:
	
	velocity.x = SPEED
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and velocity.y > -1000 and !isDead:
		velocity.y = -100
		beam.set_visible(true)

	if Input.is_action_just_pressed("ui_accept") and !isDead:
		beamSound.play(0.0)

	if Input.is_action_just_released("ui_accept"):
		beam.set_visible(false)
		beamSound.stop()

	move_and_slide()

#Custom Functions
#die function, game over that puts player at start menu
func die():
	isDead = true
	deathTimer.start()
	deathSound.play(0.0)
	GamesGlobal.dead = true

func _on_death_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/minigameScenes/ufoScenes/flyingsaucer_main_menu.tscn")
