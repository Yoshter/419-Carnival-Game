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

var canFix : bool = false
var canPlay : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if bust:
		bustCabSprites.set_visible(true)
		plugSprite.play("plugged")
	
	if hasJoyStick:
		joystickSprite.set_visible(true)
	
	match game:
		"ufo":
			ufoCabSprites.set_visible(true)
		"tower":
			towerCabSprites.set_visible(true)
			plugSprite.play("plugged")
		_:
			bustCabSprites.set_visible(true)
	
	if GamesGlobal.ufoPlugged:
		plugSprite.play("plugged")
		brokenMusic.stop()
	
	if !GamesGlobal.ufoPlugged:
		brokenMusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canFix:
		if Input.is_action_just_pressed("ui_accept"):
			fix()
	
	if canPlay and game == "ufo":
		if Input.is_action_just_pressed("ui_accept") and ItemsGlobal.checkItem("ufoToken"):
			play()
	
	if canPlay and game == "tower":
		if Input.is_action_just_pressed("ui_accept") and ItemsGlobal.checkItem("towerToken"):
			play()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !GamesGlobal.ufoPlugged:
		fixLight.set_visible(true)
		canFix = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !GamesGlobal.ufoPlugged:
		fixLight.set_visible(false)
		canFix = false

func _on_game_portal_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and (game == "tower" or GamesGlobal.ufoPlugged) and !bust:
		canPlay = true
		playLight.set_visible(true)

func _on_game_portal_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and (game == "tower" or GamesGlobal.ufoPlugged):
		canPlay = false
		playLight.set_visible(false)

func fix() -> void:
	plugSprite.play("plugged")
	GamesGlobal.ufoPlugged = true

func play() -> void:
	get_tree().change_scene_to_file(gameScene)
