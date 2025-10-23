extends TitleScreenButtons

# Get Animation player reference to play transition animation
@onready var scene_transition: = $"../../Scene_Transition/AnimationPlayer"

@onready var main_title_music: AudioStreamPlayer = $"../../Main_Title_Music"

# Get Cutscene scene (Beginning Scene) to load cutscenes
const next_scene = "res://scenes/Title-Cutscenes/beginning_cutscene.tscn"


# PLays when given a click input from left mouse click 
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			scene_transition.play("fade_in")
			
			# Play Button Clicked Sound effect
			SoundBoard.get_node("Button_Sfx").play()
			
			sound_fade_out()
			
			# Delay until instantiating the next scene
			await get_tree().create_timer(3).timeout
			get_tree().change_scene_to_file(next_scene)


# Creates a new tween that changes volume from 0 -> -80 in 1.5 seconds
func sound_fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(main_title_music, "volume_db", -80, 1.5)
