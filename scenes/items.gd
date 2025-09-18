extends Node2D

@onready var place_holder: Control = $"../Place_Holder"

var current

func _ready() -> void:
	current = place_holder
	for child in get_children():
		child.current_description.connect(current_description)

func current_description(cell):
	current.visible = false
	if cell == "Lightning":
		lightning()
	if cell == "Attack":
		Attack()
	if cell == "Defense":
		Defense()
	if cell == "Wire":
		Wire()
	$"../Purchase".visible = true

func lightning():
	$"../Speed".visible = true
	current = $"../Speed"

func Attack():
	$"../Attack".visible = true
	current = $"../Attack"
	
func Defense():
	$"../Defense".visible = true
	current = $"../Defense"

func Wire():
	#$"../Speed".visible = true
	pass
