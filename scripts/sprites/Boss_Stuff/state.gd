extends Node2D
class_name State # Will be used for other states being the children of the finite state machine

# Will try to find player to reference its positions and actions to etc
@onready var player = owner.get_parent().get_parent().get_parent().get_parent().find_child("Player")

# Responsible for playing animations of the boss relaying for each state
@onready var animation_player = owner.find_child("AnimationPlayer")

# Will deactivate the function to look for a new state for the boss to change into
func _ready() -> void:
	set_physics_process(false)
	
# Responsible for allowing a new state to be changed into for the boss
func enter():
	set_physics_process(true)

# When a state is currently playing it will no longer look for a new state until finished
func exit():
	set_physics_process(false)

# Blueprint for other Node2D to use in order to create a series of functions for the boss to play
func transition():
	pass
	
# Will keep looking for a new state to change into
func _physics_process(delta: float) -> void:
		transition()
