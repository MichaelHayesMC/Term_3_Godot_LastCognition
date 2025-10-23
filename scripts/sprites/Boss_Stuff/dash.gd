extends State

# Delay references
@onready var start_delay: Timer = $Start_delay
@onready var warning_delay: Timer = $Warning_delay
@onready var flashing_delay: Timer = $Flashing_delay

@onready var dash_sfx: AudioStreamPlayer = $Dash_sfx

var can_transition: bool = false

# Will play when the state has been called / transitioned to
func enter():
	# Short Delay until state is played
	start_delay.start()
	await start_delay.timeout
	
	# Allows the transition function to check when it can change to the next state
	super.enter()
	
	# Wait for functions and then will proceed
	await warning()
	await dash_pattern()
	
	# Ackoledges that tis state has finished and will checking for next
	can_transition = true


# Warn the player on where the boss is about to dash to
func warning():
	owner.visible = false
	owner.position = Vector2(-100,-100)
	
	warning_delay.start()
	await warning_delay.timeout
	
	#await get_tree().create_timer(0.75).timeout
	
	# Reference of the blinking indicators to warn the player
	var red_indicators = get_parent().get_parent().get_parent().get_parent().get_node("Control")
	red_indicators.visible = true
	
	# Create a blinking animation changing the opacity of all control nodes
	for i in range(6):
		red_indicators.modulate = Color(1,1,1,0.75)
		
		flashing_delay.start()
		await flashing_delay.timeout
		
		#await get_tree().create_timer(0.2).timeout
		
		red_indicators.modulate = Color(1,1,1,1)
		
		flashing_delay.start()
		await flashing_delay.timeout
		
		#await get_tree().create_timer(0.2).timeout
		
	# Finish animation with red_indicators invisible
	red_indicators.visible = false	


# Determine dash pattern of which order the boss should go in
func dash_pattern():
	# Reference to spawnpoints
	var dash_pairs = [
		["SpawnPoint1", "SpawnPoint4"],
		["SpawnPoint2", "SpawnPoint5"],
		["SpawnPoint3", "SpawnPoint6"]
	]
	
	# Look through every pair and remove the one it has processed to prevent picking the same pair twice
	for i in range(3):
		var selected_pair = dash_pairs.pick_random()
		dash_pairs.erase(selected_pair)
		await dash_randomisation(selected_pair[0], selected_pair[1])
	
	# Once Finished dash pattern boss will go back to center of the game scene
	owner.position = Vector2(114,103)


# Play the determined dash pattern	
func dash_randomisation(mark1, mark2):
	owner.visible = true
	# Have variation through changing the order of the given points per pair - by swapping each
	if randi_range(1,0) == 1:
		var temp = mark1
		mark1 = mark2
		mark2 = temp
	
	# Play correct animation dependent on the order of which the boss goes in
	if int(mark1[-1]) > int(mark2[-1]):
		animation_player.play("dash_left")
	elif int(mark1[-1]) < int(mark2[-1]):
		animation_player.play("dash_right")
	
	# Boss -> Enemies(enemy list) -> Level
	var level_reference = owner.get_parent().get_parent()
	
	dash_sfx.play()
	
	# Play animation tween for dash animation going from mark1 to mark2
	var tween = create_tween()
	owner.position = level_reference.get_node(mark1).position
	tween.tween_property(
		owner, 
		"position", 
		level_reference.get_node(mark2).position, 
		0.6
		)
	await tween.finished


# Only when finished state can it transition to the next	
func transition():
	if can_transition:
		# Ensure animation goes back to default after dash animations
		animation_player.play("idle_down")
		can_transition = false
		
		# Change state to idle to randomise for next state
		get_parent().change_state("Idle")
