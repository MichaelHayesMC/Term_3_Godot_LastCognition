extends ProgressBar


# Constantly change the appearance of the health bar matching the state of player health
func _process(_delta: float) -> void:
	value = Global.player_hp
	max_value = Global.player_max_hp
