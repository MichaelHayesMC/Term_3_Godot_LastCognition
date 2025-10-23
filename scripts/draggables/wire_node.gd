extends Area2D
class_name ConnectionPoint

# Tells when the node has connected or disconnected from a component
signal component_connected(component : CircuitComponent)
signal component_disconnected(component : CircuitComponent)

@onready var drop_sfx: AudioStreamPlayer = $Drop_sfx
@onready var pickup_sfx: AudioStreamPlayer = $Pickup_sfx

@export var draggable : bool = true

var hovering : bool = false
var dragging : bool = false
@export var previous_pos : Vector2
var inside : bool = true


func _ready() -> void:
	# When Instantiated, records it last position as the position it was loaded in as
	previous_pos = global_position


func _process(_delta):
	checkposition()
	interact_state()


# Change position relative to conditions
func checkposition():
	# Match position to mouse
	if dragging and draggable:
		global_position = get_global_mouse_position()
	# Return position to last position when outside boundary
	elif inside == false:
		global_position = previous_pos
	# Record current position when inside boundary
	elif inside == true:
		previous_pos = global_position


# Pickup states of a component
func interact_state():
	if Input.is_action_just_pressed("click_left") and hovering and not Global.block_dragging:
		dragging = true
		Global.block_dragging = true
		
		# Play sound of component being picked up
		if get_parent().is_in_group("Power") == false:
			pickup_sfx.play()

	if Input.is_action_just_released("click_left") and hovering:
		dragging = false
		Global.block_dragging = false
		
		# Play sound of component being placed down
		if get_parent().is_in_group("Power") == false:
			drop_sfx.play()


# Revert conditions of component escaping
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Module_Border"):
		inside = true
	
	if area is ConnectionPoint:
		if area.get_parent() is CircuitComponent:
			component_connected.emit(area.get_parent())


# Try to return component to module section when trying to exit and let go by the player
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Module_Border"):
		inside = false
	
	if area is ConnectionPoint:
		if area.get_parent() is CircuitComponent:
			component_disconnected.emit(area.get_parent())


# Lets the component known its interacting with the mouse
func _on_mouse_entered() -> void:
	hovering = true


# Lets the component known its not interacting with the mouse
func _on_mouse_exited() -> void:
	hovering = false
