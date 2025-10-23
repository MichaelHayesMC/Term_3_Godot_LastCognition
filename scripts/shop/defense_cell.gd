extends Sprite2D

signal current_description

var mouse_in = false


# Proceed to purchasing defense lightbulb
func _input(event) -> void:
	if event is InputEventMouseButton and mouse_in:
		if event.is_pressed():
			current_description.emit("Defense")


# Detect that mouse is about to select cell
func _on_area_2d_mouse_entered() -> void:
	mouse_in = true


# Detect that mouse is not about to select cell
func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
