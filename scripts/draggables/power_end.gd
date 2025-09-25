class_name PowerEnd 
extends CircuitComponent

@onready var on: Node2D = $Wire_Collision/On
@onready var off: Node2D = $Wire_Collision/Off

func turn_on_effect():
	on.visible = true
	off.visible = false
	Global.circuit_complete = true

func turn_off_effect():
	on.visible = false
	off.visible = true
	Global.circuit_complete = false
