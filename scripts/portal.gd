extends Node3D

@export var nextScene : String
@onready var area: Area3D = $Area3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(nextScene)
