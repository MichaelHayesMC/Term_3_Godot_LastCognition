extends Node2D

const ENEMY_1 = preload("res://scenes/sprites/enemy_1.tscn")

@onready var timer: Timer = $Timer


func _ready() -> void:
	# Short Delay until enemy spawn
	$Timer.start()


# Will Instantiate new enemies
func _on_timer_timeout() -> void:
	# Except for boss level
	if get_parent().name != "Boss_Level":
		for i in randi_range(Global.enemy_num[0], Global.enemy_num[1]):
			var new_enemy = ENEMY_1.instantiate()
			add_child(new_enemy)
	
	# Allow the Level to be Completed
	Global.room_completable = true
