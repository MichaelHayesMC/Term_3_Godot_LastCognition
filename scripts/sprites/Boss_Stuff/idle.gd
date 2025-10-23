extends State

# Reference of collision 2d to detect player
@onready var collision: CollisionShape2D = $"../../Attack_Range/CollisionShape2D"

# Constantly changing var checking the state of the player_entered variable and will change depending on its change
var player_entered : bool = false:
	set(value):
		player_entered = value
		# Will wait when ready to change the state of the collision to look for player true or false depending on the state of the player_entered
		collision.set_deferred("disabled", value)


# Will play once idl state is activated
func transition():
	# Will Randomise to choose a new state for the boss to fight against the player with a 1/3 chance	
	var randomise = randi_range(1, 4)
	
	if player_entered:
		if randomise == 1:
			get_parent().change_state("Attack")
		elif randomise == 2 or randomise == 3:
			get_parent().change_state("Summon")
		elif randomise == 4: 
			get_parent().change_state("Dash")


# Allows if the boss should start attacking the player or not
func _on_attack_range_body_entered(_body: Node2D) -> void:
	player_entered = true
