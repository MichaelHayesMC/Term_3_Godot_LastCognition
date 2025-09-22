extends Components

@onready var lightning_collision: Area2D = $Lightning_Collision

signal drag
signal drop

var player
var dragging = false

func _ready() -> void:
	last_pos = global_position
	player = get_parent()
	
func _physics_process(_delta: float) -> void:
	if not lightning_collision.get_overlapping_areas() and not draggable:
		global_position = last_pos
		inside = false
	else:
		inside = true

func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside and !player.carrying:
			draggable = true
			drag.emit()
		elif event.is_released() and mouse_in:
			draggable = false
			drop.emit()
			if lightning_collision.get_overlapping_areas():
				last_pos = position
				
func _on_lightning_collision_mouse_entered() -> void:
	mouse_in = true

func _on_lightning_collision_mouse_exited() -> void:
	mouse_in = false

func _on_lightning_collision_area_entered(area: Area2D) -> void:
	pass

func _on_lightning_collision_area_exited(area: Area2D) -> void:
	pass
