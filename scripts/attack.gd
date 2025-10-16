extends State

@onready var marker_2d: Marker2D = $"../../Marker2D"

const BULLET_ENEMY = preload("res://scenes/bullet_enemy.tscn")

var direction
var firing := false
var fires := true
var can_transition: bool = false

func enter():
	if get_tree() != null:	
		await get_tree().create_timer(2).timeout
	super.enter()
	for i in range(100):
		direction = (player.global_position - global_position).normalized()
		fire()
		if get_tree() != null:
			await get_tree().create_timer(0.2).timeout
	can_transition = true

func fire():
	var bullet = BULLET_ENEMY.instantiate()
	bullet.position = marker_2d.global_position
	bullet.direction = direction
	if get_tree() != null:
		get_tree().get_root().add_child(bullet)
	
func transition():
	if can_transition:
		can_transition = false
		#if get_tree() != null:
			#await get_tree().create_timer(2).timeout
		
		get_parent().change_state("Idle")
