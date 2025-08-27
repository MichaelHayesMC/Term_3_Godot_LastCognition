extends CharacterBody2D
class_name Player

@onready var animated_sprite := $AnimatedSprite2D
@export var SPEED =	40

var direction := Vector2.ZERO

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	


func _on_module_border_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
