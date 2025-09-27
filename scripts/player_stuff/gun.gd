extends Node2D

var _bullet_scene = preload("res://scenes/player/bullet.tscn")

var mouse_pos : Vector2
var idk : int
var shootable := true
	
func fire():
	var bullet = _bullet_scene.instantiate()
	bullet.position = $Marker2D.global_position
	bullet.direction = $Marker2D.global_position - global_position
	get_tree().get_root().add_child(bullet)

func _physics_process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	look_at(Vector2(mouse_pos.x, mouse_pos.y))
	
	if Input.is_action_pressed("click_left") and shootable and Global.circuit_complete:
		if !mouse_pos.x > 216:
			$Timer.start()
			fire()
			shootable = false

func _on_timer_timeout() -> void:
	shootable = true
