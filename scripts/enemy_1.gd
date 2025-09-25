extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var health = Global.enemy_health

var new_pos_x = randf_range(40,185)
var new_pos_y = randf_range(40,185)

func _ready() -> void:
	global_position = Vector2(new_pos_x,new_pos_y)

func apply():
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader, 1.0, 0.0, 0.5)

func set_shader(new_Value: float):
	sprite_2d.material.set_shader_parameter("blink_intensity", new_Value)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		apply()
		health -= Global.player_attack
		
func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()
		if randi_range(1, 3) == 1:
			Global.unsaved_score += 1
			print(Global.unsaved_score)
