extends creation
@onready var line_2d: Line2D = $"."

var left_side := Vector2.ZERO
var right_side := Vector2.ZERO

#func _ready() -> void:
	#print(wire_node)
	#left_side = wire_node.position
	#right_side = wire_node_2.position

#func _physics_process(delta: float) -> void:
	#left_side = (wire_node.position + wire_node.position)
	#right_side = (wire_node_2.position + wire_node_2.position)
	#line_2d.set_point_position(0, left_side)
	#line_2d.set_point_position(1, right_side)
