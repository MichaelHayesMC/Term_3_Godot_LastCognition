extends Area2D

@onready var transition: ColorRect = $"../Transition"

signal next_room


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		apply()
		
		# Play Signal to let other scripts know the player has hit the area 2d node
		next_room.emit()


# Play Transition Animation
func apply():
	var tween = get_tree().create_tween()
	tween.tween_method(set_animation, 1.0, 0.0, 2)


func set_animation(new_Value: float):
	transition.modulate = Color(1, 1, 1, new_Value)
