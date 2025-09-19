extends Node2D

@onready var place_holder: Control = $"../Place_Holder"
@onready var speed: Control = $"../Speed"
@onready var attack: Control = $"../Attack"
@onready var defense: Control = $"../Defense"
@onready var wire: Control = $"../Wire"
@onready var purchase: Label = $"../Purchase"

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
	purchase.visible = true

func lightning():
	speed.visible = true
	current = speed

func Attack():
	attack.visible = true
	current = attack
	
func Defense():
	defense.visible = true
	current = defense

func Wire():
	wire.visible = true
	current = wire
