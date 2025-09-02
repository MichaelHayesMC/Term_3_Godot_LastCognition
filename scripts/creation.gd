extends Node
class_name creation

@onready var _line_scene = preload("res://scenes/test.tscn")

var connections : Dictionary [Array, Line2D]

#@onready var wire_node: ColorRect = $Wire_Node
#@onready var wire_node_2: ColorRect = $Wire_Node2

#@onready var wire_node: ColorRect = $"../Wire_Node"
#@onready var wire_node_2: ColorRect = $"../Wire_Node2"

#func _process(delta: float) -> void:
	#on_relation_array_updated($Wire_Node, [$Wire_Node, $Wire_Node2])
	
#func on_relation_array_updated(head_node:Node, new_arr:Array)->void:
	#for other_node: Node in new_arr:
		#var node_relation_pair : Array = [head_node, other_node]
		#node_relation_pair.sort()
		#if connections.has( node_relation_pair ): continue
		#var new_line : Line2D = _line_scene.instantiate() # the Line2D scene has to have "top_level" = true
		#add_child(new_line)
		#new_line.add_point(head_node.global_position)
		#new_line.add_point(other_node.global_position)
		#connections[node_relation_pair] = new_line
