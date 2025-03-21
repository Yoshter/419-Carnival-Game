extends Node3D

var inArea : bool = false
@export var funPassLevel : int
@onready var Light : SpotLight3D = $SpotLight3D
var isVisible : bool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if isVisible:
		match funPassLevel:
			2:
				if ItemsGlobal.checkItem("funPassLevel2"):
					queue_free()
			3:
				if ItemsGlobal.checkItem("funPassLevel3"):
					queue_free()
	if inArea:
		if Input.is_action_pressed("ui_accept") and funPassLevel == 2:
			ItemsGlobal.giveItem("funPassLevel2")
			queue_free()
		if Input.is_action_pressed("ui_accept")  and funPassLevel == 3:
			ItemsGlobal.giveItem("funPassLevel3")
			queue_free()

func _on_light_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = true
		Light.set_visible(inArea)

func _on_light_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		inArea = false
		Light.set_visible(inArea)
