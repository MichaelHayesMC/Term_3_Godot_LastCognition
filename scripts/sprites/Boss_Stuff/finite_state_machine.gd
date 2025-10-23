extends Node2D

# State references
var current_state : State
var previous_state : State

# When the enemy gets instantiated it will be given a default state with animations and other actions to follow
func _ready() -> void:
	current_state = get_child(0) as State # Will make the idle node2d the default state node
	previous_state = current_state
	current_state.enter()


# Use a reference for following scripts to know which state is the one being changed from and to
func change_state(state):
	# Will find the state that is being called and undergo the actions based in the enter function of the dervided code from each script
	current_state = find_child(state) as State
	current_state.enter()
	
	# Will cancel current actions of the previous state and make the previous state the new one for other reference for newwer state calling
	previous_state.exit()
	previous_state = current_state
