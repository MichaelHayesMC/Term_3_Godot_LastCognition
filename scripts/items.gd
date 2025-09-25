extends Node2D

const LIGHTNING = preload("res://scenes/lightning.tscn")
const ATTACK = preload("res://scenes/attack.tscn")
const DEFENSE = preload("res://scenes/defense.tscn")
const WIRE = preload("res://scenes/wire.tscn")

@onready var place_holder: Control = $"../Place_Holder"
@onready var speed: Control = $"../Speed"
@onready var attack: Control = $"../Attack"
@onready var defense: Control = $"../Defense"
@onready var wire: Control = $"../Wire"
@onready var purchase: Label = $Purchase

var current

var middle_point = Vector2(300.0, 108.0)

@export var prices = {
	"Lightning" : 10,
	"Attack" : 20,
	"Defense" : 30,
	"Wire" : 5
	}

func _ready() -> void:
	current = place_holder
	for child in get_children():
		if child is Sprite2D:
			child.current_description.connect(current_description)
		elif child is Label:
			child.purchase_confirm.connect(purchase_confirm)

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

func purchase_confirm():
	if current == speed and Global.score >= prices["Lightning"]:
		
		Global.score -= prices["Lightning"]
		
		var _lightning_scene = LIGHTNING.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Bulbs")
		_lightning_scene.global_position = middle_point
		container.add_child(_lightning_scene)
	
	if current == attack and Global.score >= prices["Attack"]:
		
		Global.score -= prices["Attack"]
		
		var _attack_scene = ATTACK.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Bulbs")
		_attack_scene.global_position = middle_point
		container.add_child(_attack_scene)
		
	if current == defense and Global.score >= prices["Defense"]:
		
		Global.score -= prices["Defense"]
		
		var _defense_scene = DEFENSE.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Bulbs")
		_defense_scene.global_position = middle_point
		container.add_child(_defense_scene)
		
	if current == wire and Global.score >= prices["Wire"]:
		
		Global.score -= prices["Wire"]
		
		var _wire_scene = WIRE.instantiate()
		var world = get_parent().get_parent().get_parent().get_parent()
		var container = world.get_node("Components").get_node("Wires")
		_wire_scene.global_position = middle_point
		container.add_child(_wire_scene)
