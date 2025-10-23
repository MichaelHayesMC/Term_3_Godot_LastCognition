extends Node2D
class_name Components

@export var draggable := false
@export var last_pos : Vector2

# If mouse is inside the boundaries of components
@export var inside : bool

# If mouse is colliding with the mouse cursor
var mouse_in := false

# If the mouse is holding click on a component
var carrying : bool = false


func _process(_delta: float) -> void:
	# Ensure the component being dragged around is matching the position of the mouse
	if draggable and inside and not carrying:
		global_position = get_global_mouse_position()
	else:
		draggable = false
