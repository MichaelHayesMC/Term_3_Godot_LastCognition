extends Node2D

signal allow_circuits

var carrying = false
#var wire_collection : Array = []

func _drag() -> void:
	carrying = true
	
func _drop() -> void:
	carrying = false

func _physics_process(delta: float) -> void:
	signal_dragging_connection()
	_wire_database()

func signal_dragging_connection():
	for child in get_children():
			if child is Sprite2D:
				if child.drag.is_connected(_drag) == false:
					child.drag.connect(_drag)
				if child.drop.is_connected(_drop) == false:
					child.drop.connect(_drop)
			elif child is Node2D:
				for grandkid in child.get_children():
					if grandkid is Sprite2D:
						if grandkid.drag.is_connected(_drag) == false:
							grandkid.drag.connect(_drag)
						if grandkid.drop.is_connected(_drop) == false:
							grandkid.drop.connect(_drop)

func _wire_database():
	for child in get_children():
			if child is Sprite2D:
				pass
			elif child is Node2D:
				if child.directly_powered:
					allow_circuits.emit(true)
				else:
					allow_circuits.emit(false)
