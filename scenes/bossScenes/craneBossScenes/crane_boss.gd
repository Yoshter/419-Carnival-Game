extends CharacterBody3D

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("player")
@onready var claw: Node3D = $claw
@onready var clawDropDelayTimer: Timer = $clawDropDelayTimer

const SPEED = 5.0

var isFalling : bool = false
var inArea : bool = false
var playerInAreaTime : float = 0.0
var canMove : bool = true

func _ready() -> void:
	add_to_group("boss")

func _process(delta: float) -> void:
	print(playerInAreaTime)
	if inArea:
		playerInAreaTime += delta
		print("INAREA" + str(playerInAreaTime))

func _physics_process(delta: float) -> void:
	var dir = player.global_position - global_position
	dir = dir.normalized()
	velocity = dir * SPEED
	
	if playerInAreaTime >= 3.0:
		clawDropDelayTimer.start()
		print(playerInAreaTime)
	
	position.y = 18
	
	if canMove:
		move_and_slide()

func _on_claw_drop_delay_timer_timeout() -> void:
	claw.position.y = -16
	canMove = false

func _on_play_scan_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = true

func _on_play_scan_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
		playerInAreaTime = 0.0
