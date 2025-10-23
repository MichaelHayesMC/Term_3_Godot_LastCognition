extends Node2D

const ATTACK = preload("res://scenes/components/attack.tscn")
const DEFENSE = preload("res://scenes/components/defense.tscn")
const LIGHTNING = preload("res://scenes/components/lightning.tscn")
const WIRE = preload("res://scenes/components/wire.tscn")

# List of discriptions and names per cells / wire
@onready var place_holder: Control = $"../Place_Holder"
@onready var speed: Control = $"../Speed"
@onready var attack: Control = $"../Attack"
@onready var defense: Control = $"../Defense"
@onready var wire: Control = $"../Wire"
@onready var purchase: Label = $Purchase

# Current Discription and Name arguement
var current

# Reference where the bulbs and wires should spawn
var middle_point = Vector2(300.0, 108.0)

# Dictionary list of all prices of lightbulbs and wires
@export var prices = {
	"Lightning" : 10,
	"Attack" : 20,
	"Defense" : 30,
	"Wire" : 5
	}


func _ready() -> void:
	# Set place_holder Title and Description as current reference
	current = place_holder
	
	signal_connect()


# Connect Signals of each purchasable cell to know which is being executed
func signal_connect():
	for child in get_children():
		if child is Sprite2D:
			child.current_description.connect(current_description)
		elif child is Label:
			child.purchase_confirm.connect(purchase_confirm)


# Determine if the cell that was clicked via the signal corresponds
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


# Make cell visible and set to current
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


# Checks which of the cells is selected and uses the signal from the purchase button to execute
func purchase_confirm():
	# Only plays if selected and enough money to spend
	if current == speed and Global.score >= prices["Lightning"]:
		
		# Removes amount that it costs to buy
		Global.score -= prices["Lightning"]
		
		# Money Exchange sound effect
		SoundBoard.get_node("Money_Collect").play()
		
		# Creates new lightbulb
		var _lightning_scene = LIGHTNING.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Bulbs")
		_lightning_scene.global_position = middle_point
		container.add_child(_lightning_scene)
	
	if current == attack and Global.score >= prices["Attack"]:
		
		Global.score -= prices["Attack"]
		
		SoundBoard.get_node("Money_Collect").play()
		
		var _attack_scene = ATTACK.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Bulbs")
		_attack_scene.global_position = middle_point
		container.add_child(_attack_scene)
		
	if current == defense and Global.score >= prices["Defense"]:
		
		Global.score -= prices["Defense"]
		
		SoundBoard.get_node("Money_Collect").play()
		
		var _defense_scene = DEFENSE.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Bulbs")
		_defense_scene.global_position = middle_point
		container.add_child(_defense_scene)
		
	if current == wire and Global.score >= prices["Wire"]:
		
		Global.score -= prices["Wire"]
		
		SoundBoard.get_node("Money_Collect").play()
		
		var _wire_scene = WIRE.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Wires")
		_wire_scene.global_position = middle_point
		container.add_child(_wire_scene)
