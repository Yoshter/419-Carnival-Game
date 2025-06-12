extends Node

var dialogueText : String

var maxDialogueCount
var danEncCount = 6
var objEncCount = 0

#Naming conventions for array go "character" + "Enc(ounter)" + "(Encounter) #"
#Array STRUCTURE [Dialogue Strings, giving item after dialogue bool, if so the item, maxDialogueArrayCount]
var danEnc1 = ["A A A A H !   O  h   h-hello I didn’t s e e you there.", "U h h h m… ri-right! Y e s.", "Welcome to the  H A L F W A Y   A R C A D E  your  h a l f w a y  stop between fun and friends!", "You must be a N E W FRIEND!", "Have a T O K E N !", "Our STATE OF THE ART Digital Arcade is just down the hallway", "D o n ‘ t  g e t  l o s t .", "See ya!", true, "ufoToken", 7]
var danEnc2 = ["W O O O O O O W ! CONGRATULATIONS for beating UFO BLAST!", "For your display of INCREDIBLE SKILL and PERSEVERANCE you are rewarded…", "A N O T H E R  T O K E N ! ! !", "Travel to the FIELD GAMES Section to test your dexterity!", true, "speedPitchToken", 3]
var danEnc3 = ["Oh G-Good! You B E A T another G A M E ! ! ! ", "This was completely E X P E C T E D and A C C O U N T E D  F O R . . .", "In place of another T O K E N, please take this…", "S A W…", "I-I admit I misplaced the T H R E E other T O K E N S.", "And Y O U must F I N D them…", "P-please.", true, "saw", 6]
var danEnc4 = ["Have you found all T H R E E of the T O K E N S yet?", false, "null", 0]
var danEnc5 = ["Ah hello! Y O U have B E A T . . .", "A L L  O F  M Y  G A M E S ! ? !", "A A A A H! O-oh now the POWER is O U T.", "This... is... ", " U N S A T I S F A C T O R Y ", false, "null", 3]
var danEnc6 = ["Oh, i-it’s Y O U.", "Y O U are still H E R E .", "After I L O S T my T O K E N S .", "After you B E A T all of my G A M E S .", "And N O W . . .", "After the B L A C K O U T  that Y O U-", "N e v e r m i n d", "J u s t  l e a v e", false, "null", 7]
var danEnc7 = ["P s y c h e", false, "null", 0]

func _process(delta: float) -> void:
	if PlayerGlobal.beatCARN:
		resetDialogueGlobal()
		DialogueGlobal.danEncCount = 1
		DialogueGlobal.objEncCount = 0

func returnDialogueText(npc, dialogueCount) -> String:
	match npc:
		"CARN-E":
			match danEncCount:
				1:
					dialogueText = danEnc1[dialogueCount]
				2:
					dialogueText = danEnc2[dialogueCount]
				3:
					dialogueText = danEnc3[dialogueCount]
				4:
					dialogueText = danEnc4[dialogueCount]
				5:
					dialogueText = danEnc5[dialogueCount]
				6:
					dialogueText = danEnc6[dialogueCount]
				7:
					dialogueText = danEnc7[dialogueCount]
	return dialogueText

func returnMaxDialogueCount(npc) -> int:
	var maxCount : int
	match npc:
			"CARN-E":
				match danEncCount:
					1:
						maxCount = danEnc1[-1]
					2:
						maxCount = danEnc2[-1]
					3:
						maxCount = danEnc3[-1]
					4:
						maxCount = danEnc4[-1]
					5:
						maxCount = danEnc5[-1]
					6:
						maxCount = danEnc6[-1]
					7:
						maxCount = danEnc7[-1]
	return maxCount

func returnGivingItem(npc) -> bool:
	var beingGivenItem : bool
	match npc:
		"CARN-E":
			match danEncCount:
				1:
					beingGivenItem = danEnc1[-3]
				2:
					beingGivenItem = danEnc2[-3]
				3:
					beingGivenItem = danEnc3[-3]
				4:
					beingGivenItem = danEnc4[-3]
				5:
					beingGivenItem = danEnc5[-3]
				6:
					beingGivenItem = danEnc6[-3]
				7:
					beingGivenItem = danEnc7[-3]
				_:
					beingGivenItem = false
	return beingGivenItem

func addToEncCount(npcName) -> void:
	match npcName:
		"CARN-E":
			danEncCount += 1

func resetDialogueGlobal() -> void:
	var danEncCount = 1
	var objEncCount = 0
