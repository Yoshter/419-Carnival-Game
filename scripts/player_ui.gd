extends Control

@onready var pauseMenu : Control = $PauseMenu
@onready var getItemMenu : Control = $GetItemMenu
@onready var dialogueMenu : Control = $DialogueMenu
@onready var label : Label = $DialogueMenu/Label
@onready var dialogueTimer: Timer = $dialogueTimer

var dialogueCount : int = 0
var maxDialogueCount : int = 0
var isVisible : bool = false
var delay : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delay += delta
	if Input.is_action_just_pressed("Pause") and !isVisible and delay > 0.1:
		pauseMenu.set_visible(true)
		isVisible = true
		delay = 0.0
	if Input.is_action_just_pressed("Pause") and isVisible and delay > 0.1:
		pauseMenu.set_visible(false)
		isVisible = false
		delay = 0.0
	
	if ItemsGlobal.showItemUI:
		getItemMenu.set_visible(true)
	
	if PlayerGlobal.isTalking:
		if !dialogueCount > maxDialogueCount:
			dialogueMenu.set_visible(true)
			maxDialogueCount = DialogueGlobal.returnMaxDialogueCount(PlayerGlobal.checkIsTalkingTo())
			label.set_text(str(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), dialogueCount)))
			if dialogueTimer.is_stopped():
				dialogueTimer.start()
		else:
			dialogueCount = 0
			dialogueMenu.set_visible(false)
			if DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), -2):
				ItemsGlobal.giveItem(DialogueGlobal.returnDialogueText(PlayerGlobal.checkIsTalkingTo(), -2))
			PlayerGlobal.setIsTalking(false)
			DialogueGlobal.addToEncCount(PlayerGlobal.checkIsTalkingTo())
	

func _on_dialogue_timer_timeout() -> void:
	dialogueCount += 1
	
