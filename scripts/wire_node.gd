extends Components

@onready var wire_collision: Area2D = $Wire_Collision
@onready var _line_scene = preload("res://scenes/test.tscn")
@onready var line_2d: Line2D = $Line2D

func _physics_process(delta: float) -> void:
	if not wire_collision.get_overlapping_areas() and not draggable:
		inside = false
		global_position = last_pos
	else:
		inside = true
		
func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside:
			draggable  = true
		elif event.is_released() and mouse_in:
			draggable = false
			if wire_collision.get_overlapping_areas():
				last_pos = global_position
