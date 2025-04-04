extends CharacterBody2D

@onready var triggerArea: Area2D = $triggerArea
@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var wallCast: RayCast2D = $wallCast
@onready var wallCast2: RayCast2D = $wallCast2

var SPEED = 2.0
var isAlive : bool = true

@export var goingLeft : bool = false
@export var onCeiling : bool = true

var canTurn = true
@onready var turnAroundDelay: Timer = $turnAroundDelay

func _ready() -> void:
	add_to_group("enemy")

func _physics_process(delta: float) -> void:
	if !is_on_floor() and !onCeiling:
		velocity.y += ((SPEED * 350) * delta)
	else:
		pass
		#animatedSprite.play("ceiling")
		
	if not is_on_floor() and !onCeiling:
		pass
		#animatedSprite.play("falling")
	
	if is_on_floor() and !onCeiling:
		if goingLeft:
			velocity.x -= SPEED
		else:
			velocity.x += SPEED
		animatedSprite.play("moving")
		
	if wallCast.is_colliding() and !goingLeft and canTurn:
			goingLeft = !goingLeft
			#SPEED = -SPEED
			canTurn = false
			turnAroundDelay.start()
	if wallCast2.is_colliding() and goingLeft and canTurn:
			goingLeft = !goingLeft
			#SPEED = -SPEED
			canTurn = false
			turnAroundDelay.start()
	move_and_slide()

#Area body entered functions
func _on_trigger_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		onCeiling = false

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and isAlive:
		if body.isSpinning:
			$DeathAudio.play() #dont work
			die()
		else:
			print("die")
			body.die()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and isAlive:
		if Input.is_action_pressed("ui_accept"):
			body.jump()
		else:
			body.halfjump()
			#$DeathAudio.play() dont work
		die()

func _on_turn_around_delay_timeout() -> void:
	canTurn = true

#Custom functions
func die() -> void:
	#$DeathAudio.play() dont work
	GamesGlobal.incrementEnemiesKilled()
	queue_free()
