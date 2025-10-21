extends Control

@onready var scene_transition := $Scene_Transition/AnimationPlayer
@onready var cutscene_1: TextureRect = $Cutscene_1
@onready var cutscene_2: TextureRect = $Cutscene_2
@onready var cutscene_3: TextureRect = $Cutscene_3

const next_scene = "res://scenes/game.tscn"

var nextscene = 0

func _ready() -> void:
	cutscene_1.visible = true
	scene_transition.get_parent().get_node("ColorRect").color.a = 255
	scene_transition.play("fade_out")
	$Bubbles_sfx.play()
	await get_tree().create_timer(4).timeout
	
	animation_series()

func animation_series():
	var scenes = [cutscene_1, cutscene_2, cutscene_3]
	
	for scene in scenes:
		if scene != cutscene_3:
				
			nextscene += 1
			
			scene_transition.play("fade_in")
			scene.visible = true
			await get_tree().create_timer(3).timeout
			scene_transition.play("fade_out")
			scene.visible = false
			scenes[nextscene].visible = true
			
			if nextscene == 1:
				$Glass_breaking_sfx.play()
				await get_tree().create_timer(0.6).timeout
				$Metal_Hit_sfx.play()
			elif nextscene == 2:
				$Campfire_sfx.play()
			
			await get_tree().create_timer(3).timeout
	
	scene_transition.play("fade_in")
	$Campfire_sfx.stop()
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file(next_scene)
