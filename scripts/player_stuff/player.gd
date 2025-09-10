extends CharacterBody2D
class_name Player

enum states { IDLE, RUN, ATTACK }

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var SPEED =	40

var direction := Vector2.ZERO

func state_machine(state):
	match state:
		states.IDLE:
			animationplayer("idle")
		states.RUN:
			animationplayer("run")

func animationplayer(animation):
	match direction:
		Vector2.DOWN:
			animation_player.play(animation + "_down")
		Vector2.UP:
			animation_player.play(animation + "_up")
		Vector2.LEFT:
			animation_player.play(animation + "_left")
		Vector2.RIGHT:
			animation_player.play(animation + "_right")

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	
	if Input.is_action_pressed("move_down"):
		direction = Vector2.DOWN
		state_machine(states.RUN)
	elif Input.is_action_pressed("move_up"):
		direction = Vector2.UP
		state_machine(states.RUN)
	elif Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
		state_machine(states.RUN)
	elif Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
		state_machine(states.RUN)
	elif not velocity:
		state_machine(states.IDLE)

func _physics_process(_delta: float) -> void:
	get_input()
	#move_and_slide()
