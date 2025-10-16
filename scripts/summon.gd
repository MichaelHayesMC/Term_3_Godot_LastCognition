extends State

@export var enemy_1: PackedScene
var can_transition : bool = false

func enter():
	super.enter()
	can_transition = false
	await get_tree().create_timer(1.5).timeout
	#for i in range(3):
	spawn()
	spawn()
	await get_tree().create_timer(3).timeout
	can_transition = true
	
func spawn():
	var new_enemy = enemy_1.instantiate()
	new_enemy.position = global_position * Vector2(40,40)
	get_parent().get_parent().get_parent().call_deferred("add_child", new_enemy)
	
func transition():
	if can_transition:
		get_parent().change_state("Idle")
