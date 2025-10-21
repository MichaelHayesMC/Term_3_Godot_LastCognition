extends Label

@onready var scene_transition: = $"../Scene_Transition/AnimationPlayer"

const next_scene = "res://scenes/beginning_cutscene.tscn"

func _on_mouse_entered() -> void:
	modulate = Color.GREEN

func _on_mouse_exited() -> void:
	modulate = Color(0, .49, 0, 1)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			$Button_Sfx.play()	
			$"..".visible = false
			$"../../Credits_Page".visible = true
