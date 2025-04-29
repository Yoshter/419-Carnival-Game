extends Node3D

@onready var poleCollision1: StaticBody3D = $poleCollision
@onready var pole: Sprite3D = $"Ending Adjustments/pole"
@onready var tree_9: Node3D = $"Ending Adjustments/Tree9"
@onready var tree_10: Node3D = $"Ending Adjustments/Tree10"
@onready var poleLeft: Sprite3D = $"Ending Adjustments/PoleLeft"
@onready var poleRight: Sprite3D = $"Ending Adjustments/PoleRight"
@onready var treeBody: StaticBody3D = $"Ending Adjustments/treeBody"
var isInEndingSequence : bool = false
@onready var ambienceMusic: AudioStreamPlayer = $Ambience
@onready var rainParticles: GPUParticles3D = $Rain/RainParticles

func _process(delta: float) -> void:
	if PlayerGlobal.performanceModeOn:
		rainParticles.amount = 20000
	else:
		rainParticles.amount = 200000
	
	if PlayerGlobal.isDeaf:
		ambienceMusic.stop()
	
	if PlayerGlobal.isEndingSequence and !isInEndingSequence:
		isInEndingSequence = true
		treeBody.position.y -= 4.0
		poleCollision1.queue_free()
		pole.set_visible(false)
		tree_9.set_visible(false)
		tree_10.set_visible(true)
		poleLeft.set_visible(true)
		poleRight.set_visible(true)
		rainParticles.amount = 200000
		rainParticles.speed_scale = 1.5
