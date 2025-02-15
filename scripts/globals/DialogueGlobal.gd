extends Node

var dialogueText : String

var maxDialogueCount
var danEncCount = 1

#Naming conventions for array go "character" + "Enc(ounter)" + "(Encounter) #"
#Array STRUCTURE [Dialogue Strings, giving item after dialogue bool, if so the item, maxDialogueArrayCount]
var danEnc1 = ["Welcome", "You must be new here.", "Have a token!", "There's an arcade right down that hallway.", true, "ufoToken", 3]
var danEnc2 = ["Well done!!!", "You've earned a fun pass to the carnival games section.", true, "funPass", 1]

func returnDialogueText(npc, dialogueCount) -> String:
	match npc:
		"dan":
			match danEncCount:
				1:
					dialogueText = danEnc1[dialogueCount]
				2:
					dialogueText = danEnc2[dialogueCount]
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
	return maxCount

func addToEncCount(npcName) -> void:
	match npcName:
		"dan":
			danEncCount += 1
