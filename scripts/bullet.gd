extends Sprite2D

var direction = Vector2.RIGHT
var speed = 300

func _process(delta: float) -> void:
	global_translate(direction.normalized() * speed * delta)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	queue_free()
