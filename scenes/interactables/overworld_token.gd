extends StaticBody3D

@export var tokenString : String
@onready var shootingRangeTokenSprite: Sprite3D = $overworldToken/shootingRangeToken
@onready var skeebleTokenSprite: Sprite3D = $overworldToken/skeebleToken
@onready var towerTokenSprite: Sprite3D = $overworldToken/towerToken

@onready var rangePickUpSprite: Sprite3D = $pickUpTokens/shootingRangeToken
@onready var skeeblePickUpSprite: Sprite3D = $pickUpTokens/skeebleToken
@onready var towerPickUpSprite: Sprite3D = $pickUpTokens/towerToken

@onready var pickUpArea: Area3D = $pickUpArea

var inArea : bool = false
@export var isFallen : bool = false

func _ready() -> void:
	match tokenString:
		"tower":
			towerTokenSprite.set_visible(true)
		"shootingRange":
			shootingRangeTokenSprite.set_visible(true)
		"skeeble":
			skeebleTokenSprite.set_visible(true)

func _process(delta: float) -> void:
	print(isFallen)
	print("anything")
	if !isFallen:
		pickUpArea.set_visible(false)
		pickUpArea.set_monitoring(false)
		match tokenString:
				"tower":
					towerPickUpSprite.set_visible(true)
				"shootingRange":
					rangePickUpSprite.set_visible(true)
				"skeeble":
					skeeblePickUpSprite.set_visible(true)
	if isFallen:
		print(isFallen)
		if inArea:
			print("whoopy")
			if Input.is_action_pressed("ui_accept"):
				print("nuts")
				match tokenString:
					"tower":
						print("haha")
						ItemsGlobal.giveItem("towerToken")
					"shootingRange":
						ItemsGlobal.giveItem("rangeToken")
					"skeeble":
						ItemsGlobal.giveItem("skeebleToken")
				queue_free()

func fall() -> void:
	if !isFallen:
		pickUpArea.set_visible(true)
		pickUpArea.set_monitoring(true)
		isFallen = true
		match tokenString:
			"tower":
				global_position.y -= 4.5
			"shootingRange":
				global_position.y -= 4.0
			"skeeble":
				global_position.y -= 8
		print(isFallen)
		#global_position.y -= 8

func _on_pick_up_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(true)
		inArea = true

func _on_pick_up_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		PlayerGlobal.setCanInteract(false)
		inArea = false
