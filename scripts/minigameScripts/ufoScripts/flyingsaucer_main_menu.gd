extends Control

@onready var deathMenu: ColorRect = $deathMenu
@onready var score: Label = $deathMenu/score
@onready var tokenButton: Button = $deathMenu/tokenButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GamesGlobal.dead:
		deathMenu.set_visible(true)
		score.set_text(str(GamesGlobal.ufoScore))
		if GamesGlobal.ufoScore >= 10:
			GamesGlobal.ufoBeat = true
			tokenButton.set_visible(true)
