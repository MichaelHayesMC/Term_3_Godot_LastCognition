extends Label
class_name TitleScreenButtons

# Hovering color of label
func _on_mouse_entered() -> void:
	modulate = Color.GREEN


# Default color of label
func _on_mouse_exited() -> void:
	modulate = Color(0, .49, 0, 1)
