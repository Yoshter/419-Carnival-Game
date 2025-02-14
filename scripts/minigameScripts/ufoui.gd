extends Control

@onready var score: Label = $SCORE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score.set_text(str(GamesGlobal.ufoScore))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score.set_text(str(GamesGlobal.ufoScore))
