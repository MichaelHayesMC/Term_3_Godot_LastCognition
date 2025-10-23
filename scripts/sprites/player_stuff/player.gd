extends CharacterBody2D
class_name Player

# Reference to player Speed being a global variable for easy reference
@export var SPEED =	Global.player_speed

# Visual player references
@onready var player_texture: Sprite2D = $Visual/PlayerTexture
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Sound effect references
@onready var dash_sfx: AudioStreamPlayer = $Dash_sfx
@onready var footsteps_sfx: AudioStreamPlayer = $Footsteps_sfx

# Dash Duration and Cool_Down reference
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cool_down: Timer = $Dash_CoolDown

# States of the player
enum states { IDLE, RUN, ATTACK }

var direction := Vector2.ZERO
var dash_speed = 700
var previous_speed
var finish_cooldown := true
var footstep_volume = -7


func _physics_process(_delta: float) -> void:
	# Speed will change from added component buffs and needs to be constantly updated
	SPEED =	Global.player_speed
	
	# Prevent the player from being able to walk during transitions or interactions
	if Global.player_moveable:
		get_input()
		move_and_slide()


func get_input():
	# Get the user input to change the vector quantity thus adding to its position to make it move
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	
	movement()
	dodging()


# A prompt for the animation player to determine the direction and current state that the player goes
func movement():
	# Looks for input
	if Input.is_action_pressed("move_down"):
		# Sets direction based on a 4 directional system
		direction = Vector2.DOWN
		# Tells state machine that player is moving
		state_machine(states.RUN)
		# Sound effects
		footsteps_sfx.volume_db = footstep_volume
		Global.player_moving = true
	elif Input.is_action_pressed("move_up"):
		direction = Vector2.UP
		state_machine(states.RUN)
		footsteps_sfx.volume_db = footstep_volume
		Global.player_moving = true
	elif Input.is_action_pressed("move_left"):
		direction = Vector2.LEFT
		state_machine(states.RUN)
		footsteps_sfx.volume_db = footstep_volume
		Global.player_moving = true
	elif Input.is_action_pressed("move_right"):
		direction = Vector2.RIGHT
		state_machine(states.RUN)
		footsteps_sfx.volume_db = footstep_volume
		Global.player_moving = true
	elif not velocity:
		state_machine(states.IDLE)
		footsteps_sfx.volume_db = -80
		Global.player_moving = false


# Dashes when spacebar input it pressed
func dodging():
	if Input.is_action_pressed("dodge") and finish_cooldown:
		player_texture.modulate = Color(1,1,1,0.5)
		
		Global.player_dodging = true
		finish_cooldown = false
		dash_cool_down.start()
		previous_speed = Global.player_speed
		
		# Uses a tween to slowly change the speed of the player during its dash
		var tween = get_tree().create_tween()
		tween.tween_method(set_speed, previous_speed + 200, 10, 0.3)
		dash_sfx.play()
		dash_timer.start()


# Tell the animation player what animation to play based on input
func state_machine(state):
	match state:
		states.IDLE:
			animationplayer("idle")
		states.RUN:
			animationplayer("run")


# Will replace the arguement to keep the current direction of the player
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


func set_speed(new_Value: float):
	Global.player_speed = new_Value


# Changes the speed of the player to normal indicating the dodge has finished
func _on_dash_timer_timeout() -> void:
	Global.player_speed = previous_speed
	Global.player_dodging = false
	
	# Revert opacity to default
	player_texture.modulate = Color(1,1,1,1)


# Allows the player to dodge after the cooldown is finished
func _on_dash_cool_down_timeout() -> void:
	finish_cooldown = true
