extends Control

# Get Animation player reference to play transition animation
@onready var scene_transition := $Scene_Transition/AnimationPlayer


# Play black fade animation when this scene loads "When Game is first initiated"
func _ready() -> void:
	scene_transition.play("fade_out")
