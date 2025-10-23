extends Label

@onready var tutorial_image_library: Control = $".."


# Closes the tutorial menu
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			tutorial_image_library.visible = false
