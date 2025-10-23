extends State

# Marker on where the bullets should come form
@onready var marker_2d: Marker2D = $"../../Marker2D"

# Reference to shoot with enemy bullet scene
@export var BULLET_ENEMY : PackedScene

@onready var start_delay: Timer = $Start_delay
@onready var fire_delay: Timer = $Fire_delay

# Check is state has finished allowing it to transitiion to the next
var can_transition: bool = false

var direction

# Will play when the state has been called / transitioned to
func enter():
	# Short Delay until state is played
	start_delay.start()
	await start_delay.timeout
	
	#if get_tree() != null:	
		#await get_tree().create_timer(2).timeout
	
	## USE EITHER ABOVE DEPENDING IF IT WORKS
	
	# Allows the transition function to check when it can change to the next state
	super.enter()
	
	for i in range(70):
		direction = (player.global_position - global_position).normalized()
		fire()
		
		fire_delay.start()
		await fire_delay.timeout
		
		#if get_tree() != null:
			#await get_tree().create_timer(0.2).timeout
		
		## USE EITHER ABOVE DEPENDING IF IT WORKS	
	
	# Ackoledges that tis state has finished and will checking for next	
	can_transition = true


# Create new bullets blueprint
func fire():
	var bullet = BULLET_ENEMY.instantiate()
	bullet.position = marker_2d.global_position
	bullet.direction = direction
	
	# Check if enemy is loaded into scene and can acess this directory
	if get_tree() != null:
		get_tree().get_root().add_child(bullet)
		
		SoundBoard.get_node("Shoot2").play()


# Only when finished state can it transition to the next
func transition():
	if can_transition:
		can_transition = false
		
		# Change state to idle to randomise for next state
		get_parent().change_state("Idle")
