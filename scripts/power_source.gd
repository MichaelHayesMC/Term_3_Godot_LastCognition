extends Components

@onready var sprite_2d: Sprite2D = $"."
@onready var power_collision: Area2D = $Power_Collision

func _physics_process(delta: float) -> void:
	for area in power_collision.get_overlapping_areas():
		if area.name != "Module_Border" and not draggable:
			inside = false
			position = last_pos
		else:
			inside = true
		
		if area.name == "Power_Collision":
			modulate = Color.BLUE
		elif area.name == "Wire_Collision":
			modulate = Color.YELLOW_GREEN
		else:
			modulate = Color.ORANGE

func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside:
			draggable = true
		elif event.is_released() and mouse_in:
			draggable = false
			if power_collision.get_overlapping_areas():
				last_pos = position
				
func _on_power_collision_mouse_entered() -> void:
	mouse_in = true

func _on_power_collision_mouse_exited() -> void:
	mouse_in = false


func _on_power_collision_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_power_collision_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
