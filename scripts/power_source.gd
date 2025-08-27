extends Control

@onready var module_border: Area2D = $"../Module_Border"

@export var draggable := false
@export var last_pos : Vector2
@export var inside : bool

var centre := size / 2
var mouse_in := false

func _ready() -> void:
	last_pos = position

func _process(delta: float) -> void:
	if draggable and inside:
		position = Vector2(get_global_mouse_position().x - centre.x, get_global_mouse_position().y - centre.y)
	else:
		draggable = false

func _physics_process(delta: float) -> void:		
	if not $Power_Collision.get_overlapping_areas() and not draggable:
		inside = false
		position = last_pos
		print($Power_Collision.get_overlapping_areas(),last_pos)
	else:
		inside = true

func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside:
			draggable  = true
		elif event.is_released() and mouse_in:
			draggable = false
			if $Power_Collision.get_overlapping_areas():
				last_pos = position
				print(last_pos, $Power_Collision.get_overlapping_areas())

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false
	
