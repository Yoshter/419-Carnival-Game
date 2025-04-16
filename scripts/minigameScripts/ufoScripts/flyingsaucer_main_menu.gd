extends Control

@onready var deathMenu: ColorRect = $deathMenu
@onready var score: Label = $deathMenu/score
@onready var tokenButton: Button = $deathMenu/tokenButton

@onready var buttons: Control = $deathMenu/buttons
@onready var gameArt : TextureRect = $TextureRect
@onready var startButton: Button = $TextureRect/Button

var checked : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GamesGlobal.dead and !checked:
		deathMenu.set_visible(true)
		score.set_text(str(GamesGlobal.ufoScore))
		if GamesGlobal.ufoScore >= 10:
			if GamesGlobal.ufoBeat == false:
				DialogueGlobal.addToEncCount("dan")
				DialogueGlobal.objEncCount += 1
			GamesGlobal.ufoBeat = true
			#PlayerGlobal.inUI = true
			startButton.set_visible(false)
			buttons.set_visible(false)
			tokenButton.set_visible(true)
			GamesGlobal.ufoScoreReset()
		checked = true

func _on_token_button_pressed() -> void:
	PlayerGlobal.needsTeleport = true
	PlayerGlobal.newPosition = Vector3(-25.082,1.444,-58.956)
	get_tree().change_scene_to_file("res://scenes/gamestent.tscn")
