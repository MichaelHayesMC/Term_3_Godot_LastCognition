extends Control

# Get Animation player reference to play transition animation
@onready var scene_transition := $Scene_Transition/AnimationPlayer

# Cutscene node references
@onready var cutscene_1: TextureRect = $Cutscene_1
@onready var cutscene_2: TextureRect = $Cutscene_2
@onready var cutscene_3: TextureRect = $Cutscene_3

# Sound effect node references
@onready var bubbles_sfx: AudioStreamPlayer = $Bubbles_sfx
@onready var glass_breaking_sfx: AudioStreamPlayer = $Glass_breaking_sfx
@onready var metal_hit_sfx: AudioStreamPlayer = $Metal_Hit_sfx
@onready var campfire_sfx: AudioStreamPlayer = $Campfire_sfx

# The next scene reference of main game
const GAME = "res://scenes/game.tscn"

# Record of current scene playlist undergone
var nextscene = 0


func _ready() -> void:
	await on_load()
	animation_series()


# Responsable for the fade in transition and first cutscene effects when the scene loads
func on_load():
	scene_transition.get_parent().get_node("ColorRect").color.a = 255
	scene_transition.play("fade_out")
	
	# First Cutscene sound effect and delay to play next scene in series
	bubbles_sfx.play()
	await get_tree().create_timer(4).timeout


# Playlist of cutscene
func animation_series():
	# Reference to all scene texture nodes
	var cutscene_library = [cutscene_1, cutscene_2, cutscene_3]
	
	# Cycle through all cutscenes in array
	for cutscene in cutscene_library:
		if cutscene != cutscene_3:
				
			nextscene += 1
			
			# Transitions between cutscenes including an instatiated timeout delay
			scene_transition.play("fade_in")
			cutscene.visible = true
			await get_tree().create_timer(3).timeout
			scene_transition.play("fade_out")
			cutscene.visible = false
			cutscene_library[nextscene].visible = true
			
			# Sound Player dependent on current cutscene
			if nextscene == 1:
				glass_breaking_sfx.play()
				await get_tree().create_timer(0.6).timeout
				metal_hit_sfx.play()
			elif nextscene == 2:
				campfire_sfx.play()
			
			# Delay between each animation per cutscene
			await get_tree().create_timer(3).timeout
	
	# Final Exiting Transition preparing for main game transition
	scene_transition.play("fade_in")
	campfire_sfx.stop()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(GAME)
