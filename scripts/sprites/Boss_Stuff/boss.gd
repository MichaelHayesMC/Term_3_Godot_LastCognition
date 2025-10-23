extends CharacterBody2D

@onready var boss_texture: Sprite2D = $Visual/BossTexture
@onready var hit_sfx: AudioStreamPlayer = $Hit_sfx
@onready var dash_hitbox: Area2D = $Dash_Hitbox

var health = Global.enemy_health + 400

func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()
		if randi_range(1, 3) == 1:
			Global.unsaved_score += 1
			print(Global.unsaved_score)


# Animation that plays when the enemy is hit by player bullets
func on_hit():
	boss_texture.material.set_shader_parameter("blink_color", Color(1,1,1,1))
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader, 1.0, 0.0, 0.5)


# Acts as an object for the shader waiting to be called to play the animation
func set_shader(new_Value: float):
	boss_texture.material.set_shader_parameter("blink_intensity", new_Value)


# Decrease health when hit by a bullet
func _on_bullet_hitbox_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		on_hit()
		health -= Global.player_attack
		hit_sfx.play()


# Decrease Player HP when player gets hit by dashing attack		
func _on_dash_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.player_hp -= 20


# Activate the dash hitbox to hurt the player - activated by animationplayer
func dash_activated():
	dash_hitbox.monitoring = true


# Deactivate the dash hitbox to hurt the player - activated by animationplayer
func dash_deactivated():
	dash_hitbox.monitoring = false
