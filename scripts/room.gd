extends Node2D

var looking = true

signal level_complete

func _process(_delta: float) -> void:
	if $Enemies.get_child_count() == 0 and looking:
		$Door_Top/AnimationPlayer.play("new_animation")
		looking = false
		apply()
		
func apply():
	var tween = get_tree().create_tween()
	tween.tween_property($PointLight2D, "color", Color(1,1,1,1), 0.7)
	tween.tween_property($Vent/PointLight2D2, "color", Color(1,1,1,1), 0.7)


func _on_return_button_mouse_entered() -> void:
	pass # Replace with function body.
