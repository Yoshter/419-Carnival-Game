extends Node3D

@export var isFlickering : bool = false
var isOn : bool = false
var timeOn : float

@onready var light: SpotLight3D = $SpotLight3D

@onready var timer: Timer = $Timer

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if isFlickering and timer.is_stopped():
		timer.start()

func _on_timer_timeout() -> void:
	isOn = !isOn
	light.set_visible(!isOn)
	timer.set_wait_time(rng.randf_range(0.0, 1.2))
