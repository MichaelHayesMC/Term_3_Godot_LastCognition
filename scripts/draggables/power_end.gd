extends Components

@onready var sprite_2d: Sprite2D = $"."
@onready var power_end_collision: Area2D = $PowerEnd_Collision

signal drag
signal drop
signal complete_circuit

var player
var dragging = false

func _ready() -> void:
	last_pos = global_position
	player = get_parent()
	
	$PowerEnd_On.visible = false
	
func _physics_process(_delta: float) -> void:
	if not power_end_collision.get_overlapping_areas() and not draggable:
		global_position = last_pos
		inside = false
	else:
		inside = true
		
	for area in $PowerEnd_Collision.get_overlapping_areas():
		if area.get_parent().get_parent().is_in_group("Powered"):
			$PowerEnd_On.visible = true
			$PowerEnd_On/PowerEnd2.visible = true
			$Off_light.visible = false
			complete_circuit.emit(true)
		else:
			$PowerEnd_On.visible = false
			$PowerEnd_On/PowerEnd2.visible = false
			$Off_light.visible = true
			complete_circuit.emit(false)
			
func _input(event) -> void:
	if event is InputEventMouseButton:
		if mouse_in and event.is_pressed() and inside and !player.carrying:
			draggable = true
			drag.emit()
		elif event.is_released() and mouse_in:
			draggable = false
			drop.emit()
			if power_end_collision.get_overlapping_areas():
				last_pos = position
				
func _on_power_collision_mouse_entered() -> void:
	mouse_in = true

func _on_power_collision_mouse_exited() -> void:
	mouse_in = false

func _on_power_collision_area_entered(area: Area2D) -> void:
	pass

func _on_power_collision_area_exited(_area: Area2D) -> void:
	#modulate = Color.WHITE
	pass
