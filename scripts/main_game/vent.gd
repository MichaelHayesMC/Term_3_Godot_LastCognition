extends Sprite2D

@onready var sprite_2d: Sprite2D = $PointLight2D2/Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		sprite_2d.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		sprite_2d.visible = false

func _physics_process(_delta: float) -> void:
	if sprite_2d.visible and Input.is_action_just_pressed("interact"):
		$"../Control".visible = true
		Global.player_moveable = false
