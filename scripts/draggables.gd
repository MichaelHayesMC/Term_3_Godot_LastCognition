extends Node2D

var carrying = false

func _drag() -> void:
	carrying = true
	
func _drop() -> void:
	carrying = false

func _ready() -> void:
	for child in get_children():
		child.drag.connect(_drag)
		child.drop.connect(_drop)
