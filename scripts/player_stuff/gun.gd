extends Node2D

var _bullet_scene = preload("res://scenes/player/bullet.tscn")
@onready var power_end: Sprite2D = $Draggables/PowerEnd

var mouse_pos : Vector2
var idk : int
var shootable := true

var circuit_complete := false

func _ready() -> void:
	for child in get_parent().get_parent().get_children():
		if child.name == "Draggables":
			child.get_child(0).complete_circuit.connect(_complete_circuit)
	
func fire():
	var bullet = _bullet_scene.instantiate()
	bullet.position = $Marker2D.global_position
	bullet.direction = $Marker2D.global_position - global_position
	get_tree().get_root().add_child(bullet)

func _physics_process(_delta: float) -> void:
	mouse_pos = get_global_mouse_position()
	look_at(Vector2(mouse_pos.x, mouse_pos.y))
	
	if Input.is_action_pressed("click_left") and shootable and circuit_complete:
		if !mouse_pos.x > 216:
			$Timer.start()
			fire()
			shootable = false

func _on_timer_timeout() -> void:
	shootable = true
	
func _complete_circuit(condition):
	if condition == true:
		circuit_complete = true
	elif condition == false:
		circuit_complete = false
