extends Node3D

@export var pluggedIn : bool = false
@export var gameScene : String
@export var bust : bool = false

@onready var plugSprite: AnimatedSprite3D = $plugSprite
@onready var fixLight: SpotLight3D = $SpotLight3D
@onready var playLight: SpotLight3D = $SpotLight3D2
@onready var brokenMusic = $Brokenmusic



var canFix : bool = false
var canPlay : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if pluggedIn:
		plugSprite.play("plugged")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if canFix:
		if Input.is_action_just_pressed("ui_accept"):
			brokenMusic.stop() #Not working
			fix()
	
	if canPlay:
		if Input.is_action_just_pressed("ui_accept") and ItemsGlobal.checkItem("ufoToken"):
			play()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and !pluggedIn:
		fixLight.set_visible(true)
		canFix = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and !pluggedIn:
		fixLight.set_visible(false)
		canFix = false

func _on_game_portal_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and pluggedIn and !bust:
		canPlay = true
		playLight.set_visible(true)

func _on_game_portal_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") and pluggedIn:
		canPlay = false
		playLight.set_visible(false)

func fix() -> void:
	plugSprite.play("plugged")
	pluggedIn = true
	brokenMusic.stop() #Not working

func play() -> void:
	get_tree().change_scene_to_file(gameScene)
