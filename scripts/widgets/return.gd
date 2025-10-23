extends Label


func _on_gui_input(event: InputEvent) -> void:
	# State that the player has gone to lobby without dying
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			Global.go_back = true


# Change visuals to show mouse is hovering over label
func _on_mouse_entered() -> void:
	modulate = Color.RED

func _on_mouse_exited() -> void:
	modulate = Color.WHITE
