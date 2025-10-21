extends Area2D
class_name ConnectionPoint

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
	previous_pos = global_position

func _process(delta):		
	if dragging and draggable:
		global_position = get_global_mouse_position()
	elif inside == false:
		global_position = previous_pos
	elif inside == true:
		previous_pos = global_position

	if Input.is_action_just_pressed("click_left") and hovering and not Global.block_dragging:
		dragging = true
		Global.block_dragging = true
		
		if get_parent().is_in_group("Power") == false:
			pickup_sfx.play()

	if Input.is_action_just_released("click_left") and hovering:
		dragging = false
		Global.block_dragging = false
		
		if get_parent().is_in_group("Power") == false:
			drop_sfx.play()

	
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Module_Border"):
		inside = true
	
	if area is ConnectionPoint:
		if area.get_parent() is CircuitComponent:
			component_connected.emit(area.get_parent())
	
func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("Module_Border"):
		inside = false
	
	if area is ConnectionPoint:
		if area.get_parent() is CircuitComponent:
			component_disconnected.emit(area.get_parent())

func _on_mouse_entered() -> void:
	hovering = true


func _on_mouse_exited() -> void:
	hovering = false
