extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Visual/Sprite2D
var health = Global.enemy_health + 400

func apply():
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader, 1.0, 0.0, 0.5)

func set_shader(new_Value: float):
	sprite_2d.material.set_shader_parameter("blink_intensity", new_Value)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		apply()
		health -= Global.player_attack
		$AudioStreamPlayer2.play()
		
func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
		if randi_range(1, 3) == 1:
			Global.unsaved_score += 1
			print(Global.unsaved_score)

func _on_dash_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.player_hp -= 20
		
func dash_activated():
	$Dash_Hitbox.monitoring = true
	
func dash_deactivated():
	$Dash_Hitbox.monitoring = false
