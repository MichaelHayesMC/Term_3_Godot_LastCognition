extends CharacterBody2D
class_name Player

@onready var animated_sprite := $AnimatedSprite2D
@export var SPEED =	50

var direction := Vector2.ZERO

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#print(input_direction)
	velocity = input_direction * SPEED
	if Input.is_action_pressed("move_down"):
		animated_sprite.flip_h = false
		animated_sprite.play("walk_down")
	elif Input.is_action_pressed("move_up"):
		animated_sprite.flip_h = false
		animated_sprite.play("walk_up")
	elif Input.is_action_pressed("move_left"):
		animated_sprite.flip_h = true
		animated_sprite.play("walk_right")
	elif Input.is_action_pressed("move_right"):
		animated_sprite.flip_h = false
		animated_sprite.play("walk_right")

func _physics_process(delta: float) -> void:
	get_input()
	move_and_slide()
	
