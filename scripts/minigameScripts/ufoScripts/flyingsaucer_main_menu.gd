extends Control

@onready var deathMenu: ColorRect = $deathMenu
@onready var score: Label = $deathMenu/score
@onready var tokenButton: Button = $deathMenu/tokenButton

var checked : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GamesGlobal.dead and !checked:
		deathMenu.set_visible(true)
		score.set_text(str(GamesGlobal.ufoScore))
		if GamesGlobal.ufoScore >= 1:
			GamesGlobal.ufoBeat = true
			#PlayerGlobal.inUI = true
			tokenButton.set_visible(true)
			DialogueGlobal.addToEncCount("dan")
			GamesGlobal.ufoScoreReset()
		checked = true
