extends Control
@onready var confirmQuit: Control = $ConfirmQuit
@onready var credits_screen: Control = $CreditsScreen
@onready var button_push = $"Button Push"
@onready var start_delay = $StartDelay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func _on_quit_pressed() -> void:
	button_push.play(0.0)
	confirmQuit.set_visible (true) # Replace with function body.

func _on_no_pressed() -> void:
	button_push.play(0.0)
	confirmQuit.set_visible (false) # Replace with function body.

func _on_yes_pressed() -> void:
	button_push.play(0.0)
	get_tree().quit() # Replace with function body.


func _on_credits_pressed() -> void:
	button_push.play(0.0)
	credits_screen.set_visible (true)




func _on_close_credits_pressed() -> void:
	credits_screen.set_visible (false)
	button_push.play(0.0)


func _on_start_pressed():
	start_delay.start()
	button_push.play(0.0)


func _on_start_delay_timeout():
	get_tree().change_scene_to_file("res://scenes/outside.tscn")
