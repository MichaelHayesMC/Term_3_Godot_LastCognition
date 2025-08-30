extends Components

@onready var wire_collision: Area2D = $Wire_Collision
@onready var line_2d: Line2D = $"../Line2D"

func _physics_process(delta: float) -> void:
	if not wire_collision.get_overlapping_areas() and not draggable:
		inside = false
		position = last_pos
	else:
		inside = true
		
	for area in wire_collision.get_overlapping_areas():
		if area.name == "Power_Collision":
			if powered:
				line_2d.default_color = Color.RED
		elif area.name == "Wire_Collision":
			if powered:
				line_2d.default_color = Color.YELLOW_GREEN
		#else:
			#line_2d.default_color = Color.WHITE

func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside:
			draggable  = true
		elif event.is_released() and mouse_in:
			draggable = false
			if wire_collision.get_overlapping_areas():
				last_pos = position
