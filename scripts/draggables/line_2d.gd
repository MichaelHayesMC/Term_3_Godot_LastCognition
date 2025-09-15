extends Line2D
@onready var wire_node: Sprite2D = get_parent().get_node("Wire_Node")
@onready var wire_node_2: Sprite2D = get_parent().get_node("Wire_Node2")

#var value_from_other = wire_node.powered

var left_side := Vector2.ZERO
var right_side := Vector2.ZERO

func _ready() -> void: ## IDEK anymore
	#print(value_from_other)
	print(get_tree().get_current_scene().get_tree_string_pretty())
	print(wire_node)
	print(get_parent().get_node("Wire_Node"))
	#left_side = wire_node.position
	#right_side = wire_node_2.position

func _process(delta: float) -> void:
	#left_side = (wire_node.position + wire_node.position)
	#right_side = (wire_node_2.position + wire_node_2.position)
	set_point_position(0, wire_node.position)
	set_point_position(1, wire_node_2.position)
	
	if (wire_node.modulate == Color.BLUE or wire_node.modulate == Color.YELLOW_GREEN) and (wire_node_2.modulate == Color.YELLOW_GREEN or wire_node_2.modulate == Color.BLUE):
		color_change()
	else:
		default_color = Color(0.412,0.412,0.412,0.3)
			
func color_change():
	default_color = Color.LIME
