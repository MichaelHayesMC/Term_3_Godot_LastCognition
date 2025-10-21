extends Area2D

@onready var transition: ColorRect = $"../Transition"

signal next_room
var player1

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		apply()
		next_room.emit()
		
func apply():
	var tween = get_tree().create_tween()
	tween.tween_method(set_animation, 1.0, 0.0, 2)
	
func set_animation(new_Value: float):
	transition.modulate = Color(1, 1, 1, new_Value)
