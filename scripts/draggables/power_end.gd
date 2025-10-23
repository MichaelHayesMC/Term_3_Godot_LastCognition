class_name PowerEnd 
extends CircuitComponent

@onready var on: Node2D = $Wire_Collision/On
@onready var off: Node2D = $Wire_Collision/Off

var sound_play = true


# Display that the PowerEnd is powered
func turn_on_effect():
	on.visible = true
	off.visible = false
	Global.circuit_complete = true
	
	# Play Powered Sound
	if sound_play == true:
		sound_play = false
		SoundBoard.get_node("Lightbulb_click").play()


# Display that the PowerEnd is unpowered
func turn_off_effect():
	on.visible = false
	off.visible = true
	Global.circuit_complete = false
	
	sound_play = true
