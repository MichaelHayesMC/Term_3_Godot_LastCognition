extends Label

signal purchase_confirm

func _on_mouse_entered() -> void:
	modulate = Color.LIME

func _on_mouse_exited() -> void:
	modulate = Color(.22, .07, .09, 1)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			purchase_confirm.emit()
