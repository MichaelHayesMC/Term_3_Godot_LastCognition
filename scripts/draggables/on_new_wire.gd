extends Line2D

@onready var line_2d: Line2D = $"."
@onready var wire_collision: Area2D = $Wire_Collision

@onready var wire_node: ColorRect = $Wire_Node
@onready var wire_node_2: ColorRect = $Wire_Node2

var left_side := Vector2.ZERO
var right_side := Vector2.ZERO

func _physics_process(delta: float) -> void:
	left_side = (wire_node.size / 2 + wire_node.position)
	right_side = (wire_node_2.size / 2 + wire_node_2.position)
	set_point_position(0, left_side)
	set_point_position(1, right_side)
	
#func _process(delta: float) -> void:
	
