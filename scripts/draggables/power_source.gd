extends Components

@onready var sprite_2d: Sprite2D = $"."
@onready var power_collision: Area2D = $Power_Collision

signal drag
signal drop

var player
var dragging = false

func _ready() -> void:
	last_pos = global_position
	player = get_parent()
	
func _physics_process(_delta: float) -> void:
	if not power_collision.get_overlapping_areas() and not draggable:
		global_position = last_pos
		inside = false
	else:
		inside = true
		
	for area in power_collision.get_overlapping_areas():
		if area.name == "Power_Collision":
			modulate = Color.BLUE
		elif area.name == "Wire_Collision":
			modulate = Color.YELLOW_GREEN
		else:
			modulate = Color.WHITE

func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside and !player.carrying:
			draggable = true
			drag.emit()
		elif event.is_released() and mouse_in:
			draggable = false
			drop.emit()
			if power_collision.get_overlapping_areas():
				last_pos = position
				
func _on_power_collision_mouse_entered() -> void:
	mouse_in = true

func _on_power_collision_mouse_exited() -> void:
	mouse_in = false

func _on_power_collision_area_entered(area: Area2D) -> void:
	#if area.name == "Power_Collision":
		#modulate = Color.BLUE
	#elif area.name == "Wire_Collision":
		#modulate = Color.YELLOW_GREEN
	pass

func _on_power_collision_area_exited(_area: Area2D) -> void:
	#modulate = Color.WHITE
	pass
