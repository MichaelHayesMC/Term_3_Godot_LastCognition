extends Node2D
class_name Components

@export var draggable := false
@export var last_pos : Vector2
@export var inside : bool

var mouse_in := false

var carrying : bool = false

func _process(delta: float) -> void:
	if draggable and inside and not carrying:
		global_position = get_global_mouse_position()
	else:
		draggable = false
