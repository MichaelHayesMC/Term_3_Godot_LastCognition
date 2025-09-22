extends CharacterBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var health = 20

func apply():
	var tween = get_tree().create_tween()
	tween.tween_method(set_shader, 1.0, 0.0, 0.5)

func set_shader(new_Value: float):
	sprite_2d.material.set_shader_parameter("blink_intensity", new_Value)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		apply()
		health -= 10
		
func _process(_delta: float) -> void:
	if health <= 0:
		queue_free()
		if randi_range(1, 3) == 1:
			Global.unsaved_score += 1
			print(Global.unsaved_score)
