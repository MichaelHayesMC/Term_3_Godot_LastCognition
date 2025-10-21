extends State

var can_transition: bool = false

func enter():
	await get_tree().create_timer(2).timeout
	super.enter()
	await warning()
	await dash_pattern()
	can_transition = true


func warning():
	owner.visible = false
	owner.position = Vector2(-100,-100)
	
	await get_tree().create_timer(0.75).timeout
	
	var red_indicators = get_parent().get_parent().get_parent().get_parent().get_node("Control")
	red_indicators.visible = true
	
	for i in range(6):
		red_indicators.modulate = Color(1,1,1,0.75)
		await get_tree().create_timer(0.2).timeout
		red_indicators.modulate = Color(1,1,1,1)
		await get_tree().create_timer(0.2).timeout
		
	red_indicators.visible = false	
	
func dash_pattern():
	var dash_pairs = [
		["SpawnPoint1", "SpawnPoint4"],
		["SpawnPoint2", "SpawnPoint5"],
		["SpawnPoint3", "SpawnPoint6"]
	]
	
	for i in range(3):
		var selected_pair = dash_pairs.pick_random()
		dash_pairs.erase(selected_pair)
		await dash_randomisation(selected_pair[0], selected_pair[1])
	
	owner.position = Vector2(114,103)
	
func dash_randomisation(mark1, mark2):
	owner.visible = true
	if randi_range(1,0) == 1:
		var temp = mark1
		mark1 = mark2
		mark2 = temp
	
	if int(mark1[-1]) > int(mark2[-1]):
		animation_player.play("dash_left")
	elif int(mark1[-1]) < int(mark2[-1]):
		animation_player.play("dash_right")
	
	var level_reference = get_parent().get_parent().get_parent().get_parent()
	
	$AudioStreamPlayer.play()
	
	var tween = create_tween()
	owner.position = level_reference.get_node(mark1).position
	tween.tween_property(owner, "position", level_reference.get_node(mark2).position, 0.6)
	await tween.finished
	
func transition():
	if can_transition:
		animation_player.play("idle_down")
		can_transition = false
		get_parent().change_state("Idle")
