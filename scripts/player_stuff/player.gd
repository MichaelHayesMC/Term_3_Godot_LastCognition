extends CharacterBody2D
class_name Player

enum states { IDLE, RUN, ATTACK }

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var SPEED =	Global.player_speed

var previous_speed
var finish_cooldown := true

var direction := Vector2.ZERO
var dash_speed = 700
var footstep_volume = -20

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
		$Footsteps_sfx.volume_db = footstep_volume
	elif Input.is_action_pressed("move_up"):
		direction = Vector2.UP
		state_machine(states.RUN)
		$Footsteps_sfx.volume_db = footstep_volume
	elif Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
		state_machine(states.RUN)
		$Footsteps_sfx.volume_db = footstep_volume
	elif Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
		state_machine(states.RUN)
		$Footsteps_sfx.volume_db = footstep_volume
	elif not velocity:
		state_machine(states.IDLE)
		$Footsteps_sfx.volume_db = -80
		
	if Input.is_action_pressed("dodge") and finish_cooldown:
		Global.player_dodging = true
		finish_cooldown = false
		$Dash_CoolDown.start()
		previous_speed = Global.player_speed
		var tween = get_tree().create_tween()
		tween.tween_method(set_speed, previous_speed + 200, 10, 0.3)
		$Dash_sfx.play()
		$DashTimer.start()

func _physics_process(_delta: float) -> void:
	SPEED =	Global.player_speed
	
	if Global.player_moveable:
		get_input()
		move_and_slide()

func _on_dash_timer_timeout() -> void:
	Global.player_speed = previous_speed
	Global.player_dodging = false

func set_speed(new_Value: float):
	Global.player_speed = new_Value


func _on_dash_cool_down_timeout() -> void:
	finish_cooldown = true
