extends State

# Delay timers reference
@onready var start_delay: Timer = $Start_delay
@onready var transition_delay: Timer = $Transition_delay

# Enemy spawn reference
@export var enemy_1: PackedScene

# Check is state has finished allowing it to transitiion to the next
var can_transition : bool = false
var spawn_count := 2


func enter():
	super.enter()
	can_transition = false
	
	# Short Delay until state is played
	start_delay.start()
	await start_delay.timeout
	#await get_tree().create_timer(1.5).timeout
	## USE EITHER ABOVE DEPENDING IF IT WORKS
	
	# Spawn number of enemies dependent on set spawn count
	for i in range(spawn_count):
		spawn()
	
	transition_delay.start()
	await transition_delay.timeout
	#await get_tree().create_timer(3).timeout
	## USE EITHER ABOVE DEPENDING IF IT WORKS
	
	can_transition = true


# Randomise the location in which the enemy spawns relative to the boss	
func spawn():
	var new_enemy = enemy_1.instantiate()
	new_enemy.position = global_position * Vector2(40,40)
	# Reference to enemies(enemy list) location
	owner.get_parent().call_deferred("add_child", new_enemy)


# Only when finished state can it transition to the next	
func transition():
	if can_transition:
		# Change state to idle to randomise for next state
		get_parent().change_state("Idle")
