extends Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$PointLight2D2/Sprite2D.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$PointLight2D2/Sprite2D.visible = false
