extends Node

var dialogueText : String

var maxDialogueCount
var danEncCount = 1
var objEncCount = 0

#Naming conventions for array go "character" + "Enc(ounter)" + "(Encounter) #"
#Array STRUCTURE [Dialogue Strings, giving item after dialogue bool, if so the item, maxDialogueArrayCount]
var danEnc1 = ["Welcome", "You must be new here.", "Have a token!", "There's an arcade right down that hallway.", true, "ufoToken", 3]
var danEnc2 = ["Well done!!!", "You've earned another token!", "Go try the Speed Pitch game in the Carnival Games section.", true, "speedPitchToken", 2]
var danEnc3 = ["Good job on that last game kid!", "I'd give you another token, but I can't remember where I put 'em.", "Have a saw! I think I remember there being some boards over in the arcade if you're... BOARED!", true, "saw", 2]
var danEnc4 = ["Keep looking for those tokens!", false, "null", 0]
var danEnc5 = ["Hey, look at all those tic...", "Darn, looks like the power went out, you better go find the breaker room and fix it!", "Thanks!", false, "null", 2]
var danEnc6 = ["You DID it! By the way, I found this random key if you want it.", false, "null", 0]

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
				4:
					dialogueText = danEnc4[dialogueCount]
				5:
					dialogueText = danEnc5[dialogueCount]
				6:
					dialogueText = danEnc6[dialogueCount]
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
					4:
						maxCount = danEnc4[-1]
					5:
						maxCount = danEnc5[-1]
					6:
						maxCount = danEnc6[-1]
	return maxCount

func returnGivingItem(npc) -> bool:
	var beingGivenItem : bool
	match npc:
		"dan":
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
				
	return beingGivenItem

func addToEncCount(npcName) -> void:
	match npcName:
		"dan":
			danEncCount += 1

func resetDialogueGlobal() -> void:
	var danEncCount = 1
	var objEncCount = 0
