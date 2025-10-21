extends Label

@onready var scene_transition: = $"../../Scene_Transition/AnimationPlayer"

const next_scene = "res://scenes/beginning_cutscene.tscn"

func _on_mouse_entered() -> void:
	modulate = Color.GREEN

func _on_mouse_exited() -> void:
	modulate = Color(0, .49, 0, 1)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			scene_transition.play("fade_in")
			$Button_Sfx.play()
			
			var tween = get_tree().create_tween()
			tween.tween_property($"../Main_Title_Music", "volume_db", -80, 1.5)
			
			
			await get_tree().create_timer(3).timeout
			get_tree().change_scene_to_file(next_scene)
