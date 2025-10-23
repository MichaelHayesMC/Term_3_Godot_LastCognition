extends Sprite2D

@onready var sprite_2d: Sprite2D = $PointLight2D2/Sprite2D
@onready var choice_interface: Control = $"../Choice_Interface"


func _physics_process(_delta: float) -> void:
	# Ensure player is unable to move having to choose whether to return to lobby or continue
	if sprite_2d.visible and Input.is_action_just_pressed("interact"):
		choice_interface.visible = true
		Global.player_moveable = false


# Check is player is not in range to not give prompt from ventilation
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		sprite_2d.visible = true


# Check is player is in range to give prompt from ventilation
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		sprite_2d.visible = false
