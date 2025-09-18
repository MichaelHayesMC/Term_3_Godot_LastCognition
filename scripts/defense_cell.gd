extends Sprite2D

signal current_description

var mouse_in = false

func _input(event) -> void:
	if event is InputEventMouseButton and mouse_in:
		if event.is_pressed():
			current_description.emit("Defense")

func _on_area_2d_mouse_entered() -> void:
	mouse_in = true
	
func _on_area_2d_mouse_exited() -> void:
	mouse_in = false
