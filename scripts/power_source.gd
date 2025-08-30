extends Components

@onready var power_collision: Area2D = $Power_Collision

func _physics_process(delta: float) -> void:
	if not power_collision.get_overlapping_areas() and not draggable:
		inside = false
		position = last_pos
	else:
		inside = true
	
	for area in power_collision.get_overlapping_areas():
		if area.name == "Power_Collision":
			$".".color = Color.RED
		elif area.name == "Wire_Collision":
			$".".color = Color.YELLOW_GREEN
		else:
			$".".color = Color.ORANGE

func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside:
			draggable  = true
		elif event.is_released() and mouse_in:
			draggable = false
			if power_collision.get_overlapping_areas():
				last_pos = position
