extends Sprite2D
class_name Bullet

var direction = Vector2.RIGHT
var speed = 300

enum type {ALLY, ENEMY}

@export var typing : type

func _process(delta: float) -> void:
	match typing:
		type.ALLY:
			global_translate(direction.normalized() * speed * delta)
		type.ENEMY:
			global_translate(direction.normalized() * (int(speed) - 225) * delta)

func _on_area_2d_body_entered(body: Node2D) -> void:
	match typing:
		type.ALLY:
			if !body.is_in_group("Player"):
				queue_free()
		type.ENEMY:
			if !body.is_in_group("Enemy"):
				if body.name == "Player" and !Global.player_dodging:
					Global.player_hp -= Global.enemy_damage
					queue_free()
				elif body.name != "Player":
					queue_free()
