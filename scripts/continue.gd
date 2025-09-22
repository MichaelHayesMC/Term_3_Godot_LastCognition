extends Label

func _on_mouse_entered() -> void:
	modulate = Color.LIME

func _on_mouse_exited() -> void:
	modulate = Color.WHITE

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			Global.player_moveable = true
			$"..".visible = false
