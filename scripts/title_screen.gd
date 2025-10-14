extends Control

@onready var scene_transition := $Scene_Transition/AnimationPlayer

func _ready() -> void:
	scene_transition.play("fade_out")
