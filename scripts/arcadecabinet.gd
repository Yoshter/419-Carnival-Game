extends Node3D

#@export var pluggedIn : bool = false
@export var gameScene : String
@export var bust : bool = false
@export var game : String
@export var hasJoyStick : bool = true

@onready var joystickSprite: Sprite3D = $bodySprites/joystickSprite

@onready var plugSprite: AnimatedSprite3D = $bodySprites/plugSprite
@onready var fixLight: SpotLight3D = $SpotLight3D
@onready var playLight: SpotLight3D = $SpotLight3D2
@onready var brokenMusic: AudioStreamPlayer3D = $Brokenmusic

@onready var ufoCabSprites: Node3D = $bodySprites/ufoCabSprites
@onready var towerCabSprites: Node3D = $bodySprites/towerCabSprites
@onready var bustCabSprites: Node3D = $bodySprites/bustCabSprites
@onready var fixNoise = $FixNoise

@onready var gamePortal : Area3D = $gamePortal
@onready var joystickFixArea : Area3D = $joystickFixArea
@onready var plugArea: Area3D = $Area3D

var canFix : bool = false
var canPlay : bool = false
var canReplaceJoystick : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if bust:
		bustCabSprites.set_visible(true)
		plugSprite.play("plugged")
		plugArea.set_monitoring(false)
	
	if hasJoyStick:
		joystickSprite.set_visible(true)
	
	match game:
		"ufo":
			ufoCabSprites.set_visible(true)
			brokenMusic.play(0.0)
		"tower":
			towerCabSprites.set_visible(true)
			gamePortal.monitoring = false
			plugArea.set_monitoring(false)
			plugSprite.play("plugged")
		_:
			bustCabSprites.set_visible(true)
	
	if GamesGlobal.ufoPlugged:
		plugSprite.play("plugged")
		if brokenMusic.is_playing():
			brokenMusic.stop()
	
	#if !GamesGlobal.ufoPlugged:
		#brokenMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canFix:
		if Input.is_action_just_pressed("ui_accept"):
			fix()
	
	if (canReplaceJoystick and Input.is_action_pressed("ui_accept")) or GamesGlobal.towerHasJoystick:
			hasJoyStick = true
			joystickSprite.set_visible(true)
			joystickFixArea.monitorable = false
			joystickFixArea.monitoring = false
			gamePortal.monitoring = true
			
			GamesGlobal.towerHasJoystick = true
	
	if canPlay and game == "ufo":
		if Input.is_action_just_pressed("ui_accept") and ItemsGlobal.checkItem("ufoToken"):
			play()
	
	if canPlay and game == "tower":
		if Input.is_action_just_pressed("ui_accept") and ItemsGlobal.checkItem("towerToken"):
			play()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !GamesGlobal.ufoPlugged:
		PlayerGlobal.setCanInteract(true)
		fixLight.set_visible(true)
		canFix = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !GamesGlobal.ufoPlugged:
		PlayerGlobal.setCanInteract(false)
		fixLight.set_visible(false)
		canFix = false

func _on_game_portal_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and (game == "tower" or GamesGlobal.ufoPlugged) and !bust and hasJoyStick:
		match game:
			"ufo":
				if ItemsGlobal.checkItem("ufoToken"):
					PlayerGlobal.setCanInteract(true)
			"tower":
				if ItemsGlobal.checkItem("towerToken"):
					PlayerGlobal.setCanInteract(true)
		canPlay = true
		playLight.set_visible(true)

func _on_game_portal_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and (game == "tower" or GamesGlobal.ufoPlugged):
		match game:
			"ufo":
				if ItemsGlobal.checkItem("ufoToken"):
					PlayerGlobal.setCanInteract(false)
			"tower":
				if ItemsGlobal.checkItem("towerToken"):
					PlayerGlobal.setCanInteract(false)
		canPlay = false
		playLight.set_visible(false)

func fix() -> void:
	plugSprite.play("plugged")
	brokenMusic.volume_db = -80.0
	GamesGlobal.setUfoPlugged(true)
	canFix = false
	PlayerGlobal.setCanInteract(false)
	fixNoise.play(0.0) #Bug where it will continue playing the sound on subsequent space presses

func play() -> void:
	get_tree().change_scene_to_file(gameScene)


func _on_joystick_fix_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !hasJoyStick and !bust and ItemsGlobal.checkItem("joystick"):
		PlayerGlobal.setCanInteract(true)
		canReplaceJoystick = true

func _on_joystick_fix_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !hasJoyStick and !bust and ItemsGlobal.checkItem("joystick"):
		PlayerGlobal.setCanInteract(false)
		canReplaceJoystick = false
