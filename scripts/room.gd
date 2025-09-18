extends Node2D

var looking = true

func _process(delta: float) -> void:
	if $Enemies.get_child_count() == 0 and looking:
		$Door_Top/AnimationPlayer.play("new_animation")
		looking = false
		apply()
		
func apply():
	var tween = get_tree().create_tween()
	tween.tween_property($PointLight2D, "color", Color(1,1,1,1), 0.7)
