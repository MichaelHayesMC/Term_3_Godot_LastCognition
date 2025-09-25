extends Node2D

const ENEMY_1 = preload("res://scenes/enemy_1.tscn")
	
func _ready() -> void:
	for i in Global.enemy_num:
		var new_enemy = ENEMY_1.instantiate()
		add_child(new_enemy)
