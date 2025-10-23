extends CharacterBody2D

# Reference for the different bullet the enemy will be firing
@export var BULLET_ENEMY : PackedScene

# Player Reference located in game scene
@onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player")

# Visual Node references
@onready var sprite_2d: Sprite2D = $Visual/Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var hit_sfx: AudioStreamPlayer = $Hit_sfx
@onready var fire_intervals: Timer = $Fire_Intervals

# Reference where the bullet will spawn
@onready var marker_2d: Marker2D = $Marker2D

enum states { IDLE, RUN }

# Used to randomise the position 
var new_pos_x = randf_range(40,185)
var new_pos_y = randf_range(40,130)

var health = Global.enemy_health
var should_chase := true
var speed = 15
var firing : bool = false
var direction
var can_move = false
var cooldown_done = true


# Change if the enemy should be playing idle or run animations dependent on external conditions
func state_machine(state):
	# Check if state mactches parameter
	match state:
		states.IDLE:
			animationplayer("idle")
		states.RUN:
			animationplayer("run")


# Play animation dependent on its direction and if its arguement on current state
func animationplayer(animation):
	if direction.y < -0.5:
		animation_player.play(animation + "_up")
	elif direction.y > 0.5:
		animation_player.play(animation + "_down")
	elif direction.x > 0:
		animation_player.play(animation + "_right")
	elif direction.x < 0:
		animation_player.play(animation + "_left")


func _ready() -> void:	
	# Wwhere the enemy will be placed when instantiated and in the confines of the game scene
	global_position = Vector2(new_pos_x,new_pos_y)
	
	await on_load_animation()

	# Enemy will only move when animation has finished
	can_move = true


func _process(delta: float) -> void:
	shoot_check()
	currency_increase()
	movement(delta)


# Allows the enemy move to player ensuring animation and direction is correct
func movement(delta: float) -> void:
	direction = (player.global_position - global_position).normalized()
	
	if should_chase and can_move:
		velocity = lerp(velocity, direction * speed, 8.5*delta)
		move_and_slide()
		state_machine(states.RUN)
	elif !should_chase:
		state_machine(states.IDLE)


# Check is enemy conditions allow it to fight - dependent on state etc
func shoot_check():
	if firing and cooldown_done and can_move:
			cooldown_done = false
			fire()
			fire_intervals.start()


# Create new bullets blueprint
func fire():
	var bullet = BULLET_ENEMY.instantiate()
	bullet.position = marker_2d.global_position
	bullet.direction = direction
	get_tree().get_root().add_child(bullet)
	
	SoundBoard.get_node("Shoot2").play()


# Will randomly add 1 to the temporary score when health is 0
func currency_increase():
	if health <= 0:
		if randi_range(1, 2) == 1:
			Global.unsaved_score += 1
			SoundBoard.get_node("Money_Collect").play()
		
		# Only delete from scene when available
		queue_free.call_deferred()


# Animation that plays when the enemy loads into scene
func on_load_animation():
	var tween = get_tree().create_tween()
	
	# Reference to shader responsible for visuals of enemy
	sprite_2d.material.set_shader_parameter("blink_color", Color(1,0,0,1))
	tween.tween_method(set_shader, 1.0, 0.0, 1.5)
	
	await tween.finished


# Animation that plays when the enemy is hit by player bullets
func on_hit():
	sprite_2d.material.set_shader_parameter("blink_color", Color(1,1,1,1))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader, 1.0, 0.0, 0.5)


# Acts as an object for the shader waiting to be called to play the animation
func set_shader(new_Value: float):
	sprite_2d.material.set_shader_parameter("blink_intensity", new_Value)


# Decrease health when hit by a bullet
func _on_bullet_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		on_hit()
		health -= Global.player_attack
		hit_sfx.play()


# Will attack the player when in range
func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		velocity = Vector2(0,0)
		should_chase = false
		firing = true


# Will no longer attack and will most likely try to walk closer
func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		should_chase = true
		firing = false


# Detect if player is in range for the enemy to walk towards the player / be aggravated	
func _on_walk_to_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		should_chase = true


# Detect when no longer in range it will not attack player		
func _on_walk_to_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		should_chase = false


# Intervals of when each bullet should be fired
func _on_fire_intervals_timeout() -> void:
	cooldown_done = true


# Prevent enemies from occupying the same spot when instantiating onto game scene
func _on_interesect_detection_area_entered(area: Area2D) -> void:
	if area.name == "Area2D2":
		# Look for new positions
		global_position = Vector2(new_pos_x,new_pos_y)
