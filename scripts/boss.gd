extends CharacterBody2D

const BULLET_ENEMY = preload("res://scenes/bullet_enemy.tscn")


@onready var sprite_2d: Sprite2D = $Visual/Sprite2D
var health = Global.enemy_health

@onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum states { IDLE, RUN }

var should_chase := true
var speed = 15
var firing : bool = false
var direction

var cooldown_done = true

func apply():
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader, 1.0, 0.0, 0.5)

func set_shader(new_Value: float):
	sprite_2d.material.set_shader_parameter("blink_intensity", new_Value)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		apply()
		health -= Global.player_attack
		
func _process(delta: float) -> void:
	if firing and cooldown_done:
			cooldown_done = false
			fire()
			$Fire_Intervals.start()
		
	if health <= 0:
		queue_free()
		if randi_range(1, 3) == 1:
			Global.unsaved_score += 1
			print(Global.unsaved_score)
	
	direction = (player.global_position - global_position).normalized()
	
	#if should_chase:
		#velocity = lerp(velocity, direction * speed, 8.5*delta)
		#move_and_slide()
		#state_machine(states.RUN)
	#elif !should_chase:
		#state_machine(states.IDLE)
	
func state_machine(state):
	match state:
		states.IDLE:
			animationplayer("idle")
		states.RUN:
			animationplayer("run")

func animationplayer(animation):
	if direction.y < -0.5:
		$AnimationPlayer.play(animation + "_up")
	elif direction.y > 0.5:
		$AnimationPlayer.play(animation + "_down")
	elif direction.x > 0:
		$AnimationPlayer.play(animation + "_right")
	elif direction.x < 0:
		$AnimationPlayer.play(animation + "_left")


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		velocity = Vector2(0,0)
		should_chase = false
		firing = true

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		should_chase = true
		firing = false
		
func _on_walk_to_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		should_chase = true
		
func _on_walk_to_range_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		should_chase = false

func _on_fire_intervals_timeout() -> void:
	cooldown_done = true
	
func fire():
	var bullet = BULLET_ENEMY.instantiate()
	bullet.position = $Marker2D.global_position
	bullet.direction = direction
	get_tree().get_root().add_child(bullet)
