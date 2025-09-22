extends Components

@onready var wire_collision: Area2D = $Wire_Collision
@onready var _line_scene = preload("res://scenes/test.tscn")
#@onready var line_2d: Line2D = $Line2D

signal drag
signal drop

var player
var dragging = false

@export var powered = false
var directly_powered = false

func _ready() -> void:
	last_pos = global_position
	player = get_parent().get_parent()

func _physics_process(_delta: float) -> void:
	if not wire_collision.get_overlapping_areas() and not draggable:
		global_position = last_pos
		inside = false
	else:
		inside = true
	
	for area in wire_collision.get_overlapping_areas():
		if area.name == "PowerStart_Collision" and area.get_parent().is_in_group("Powered"):
				modulate = Color.BLUE
				powered = true
				directly_powered = true
		elif area.name == "Wire_Collision" and area.get_parent().get_parent().is_in_group("Powered") and !area.get_parent().powered:
				modulate = Color.YELLOW_GREEN
				powered = true
		#elif area.name == "Lightning_Collision":
			#modulate = Color.ORANGE
			#powered = true
		else:
			modulate = Color.WHITE
			powered = false
			directly_powered = false
		
func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside and !player.carrying:
			draggable = true
			drag.emit()
		elif event.is_released() and mouse_in:
			draggable = false
			drop.emit()
			if wire_collision.get_overlapping_areas():
				last_pos = position

func _on_wire_collision_mouse_entered() -> void:
	mouse_in = true

func _on_wire_collision_mouse_exited() -> void:
	mouse_in = false
	
func _on_wire_collision_area_entered(area: Area2D) -> void:
	pass
	#if area.name == "Power_Collision":
		#modulate = Color.BLUE
	#elif area.name == "Wire_Collision":
		#modulate = Color.YELLOW_GREEN

func _on_wire_collision_area_exited(_area: Area2D) -> void:
	pass
	#modulate = Color.WHITE
