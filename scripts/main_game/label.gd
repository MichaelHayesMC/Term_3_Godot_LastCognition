extends Label

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			print("click")
			$"..".visible = false


func _on_mouse_entered() -> void:
	print("yes")
