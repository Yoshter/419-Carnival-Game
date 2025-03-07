extends Node

var dialogueText : String

var maxDialogueCount
var danEncCount = 1

#Naming conventions for array go "character" + "Enc(ounter)" + "(Encounter) #"
#Array STRUCTURE [Dialogue Strings, giving item after dialogue bool, if so the item, maxDialogueArrayCount]
var danEnc1 = ["Welcome", "You must be new here.", "Have a token!", "There's an arcade right down that hallway.", true, "ufoToken", 3]
var danEnc2 = ["Well done!!!", "You've earned another token!", "Go try the Speed Pitch game in the Carnival Games section.", true, "speedPitchToken", 2]
var danEnc3 = ["Good job on that last game kid!", "I'd give you another token, but I can't remember where I put 'em.", "Have a saw! I think I remember there being some boards over in the arcade if you're... BOARED!", true, "saw", 2]

func returnDialogueText(npc, dialogueCount) -> String:
	match npc:
		"dan":
			match danEncCount:
				1:
					dialogueText = danEnc1[dialogueCount]
				2:
					dialogueText = danEnc2[dialogueCount]
				3:
					dialogueText = danEnc3[dialogueCount]
	return dialogueText

func returnMaxDialogueCount(npc) -> int:
	var maxCount : int
	match npc:
			"dan":
				match danEncCount:
					1:
						maxCount = danEnc1[-1]
					2:
						maxCount = danEnc2[-1]
					3:
						maxCount = danEnc3[-1]
	return maxCount

func addToEncCount(npcName) -> void:
	match npcName:
		"dan":
			danEncCount += 1
