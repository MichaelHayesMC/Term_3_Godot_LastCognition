extends Node2D

# Reference to animation player of door to slide open
@onready var animation_player: AnimationPlayer = $Door_Top/AnimationPlayer

# Light Effect for Door opening
@onready var door_light: PointLight2D = $DoorLight

@onready var enemies: Node2D = $Enemies

# Prevents the door from playing animation more than once
var looking = true


func _ready() -> void:
	# Default room unable to complete
	Global.room_completable = false
	
	soundplay()


func _process(_delta: float) -> void:
	completable()
	enemy_counting()


# Play sounds per level
func soundplay():
	# Play Generic Level Sounds if not already
	if !SoundBoard.get_node("Fighting_Music").playing:
		SoundBoard.get_node("Fighting_Music").play()
	
	# Mute Generic Level Sounds
	if self.name == "Checkpoint" or self.name == "Boss_Level":
		SoundBoard.get_node("Fighting_Music").stop()


# Check until there are no more enemies left on the level
func enemy_counting():
	if enemies.get_child_count() <= 1 and looking and Global.room_completable:
		animation_player.play("new_animation")
		looking = false
		light_animation()


# On default open door for checkpoint
func completable():
	if self.name == "Checkpoint":
		Global.room_completable = true


# Animation played once level completed
func light_animation():
	var tween = get_tree().create_tween()
	tween.tween_property(door_light, "color", Color(1,1,1,1), 0.7)
	
	# Play animation for vent light when level is checkpoint
	if name == "Checkpoint":
		tween.tween_property($Vent/PointLight2D2, "color", Color(1,1,1,1), 0.7)
