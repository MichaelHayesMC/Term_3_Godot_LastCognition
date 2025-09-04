extends Node2D

var carrying = false

func _drag() -> void:
	carrying = true
	
func _drop() -> void:
	carrying = false

func _ready() -> void:
	for child in get_children():
		if child is Sprite2D:
			child.drag.connect(_drag)
			child.drop.connect(_drop)
		elif child is Node2D:
			for grandkid in child.get_children():
				if grandkid is Sprite2D:
					grandkid.drag.connect(_drag)
					grandkid.drop.connect(_drop)
