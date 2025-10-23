extends Label

signal purchase_confirm


# Emit Signal that a selected cell is about to be purchased
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			purchase_confirm.emit()


# Change colour as mouse hovers over label
func _on_mouse_entered() -> void:
	modulate = Color.LIME

# Change colour as mouse does not hover over label
func _on_mouse_exited() -> void:
	modulate = Color(.22, .07, .09, 1)
