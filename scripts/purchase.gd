extends Label

func _on_mouse_entered() -> void:
	modulate = Color.LIME

func _on_mouse_exited() -> void:
	modulate = Color(.22, .07, .09, 1)
