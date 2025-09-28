extends Node
class_name creation

#@onready var _line_scene = preload("res://scenes/test.tscn")

var connections : Dictionary [Array, Line2D]
var allow_ = false

@onready var wire_node: Sprite2D = $Wire_Node
@onready var wire_node_2: Sprite2D = $Wire_Node2
var _line_scene = preload("res://scenes/test.tscn")

@export var powered = false
var directly_powered = false

func _ready() -> void:
	var new_line: Line2D = _line_scene.instantiate()
	add_child(new_line)

	if wire_node and wire_node_2:
		new_line.add_point(wire_node.position)
		new_line.add_point(wire_node_2.position)
	else:
		push_error("Wire nodes not found — check your scene tree paths")


	#on_relation_array_updated(wire_node, [wire_node, wire_node_2])
	
#func _physics_process(delta: float) -> void:
	#on_relation_array_updated(wire_node, [wire_node, wire_node_2])
	
func on_relation_array_updated(head_node : Node, new_arr : Array) -> void:
	for other_node: Node in new_arr:
		var node_relation_pair : Array = [head_node, other_node]
		node_relation_pair.sort()
		if connections.has( node_relation_pair ): continue
		var new_line : Line2D = _line_scene.instantiate() # the Line2D scene has to have "top_level" = true
		add_child(new_line)
		new_line.add_point(head_node.position)
		new_line.add_point(other_node.position)
		connections[node_relation_pair] = new_line

func _physics_process(delta: float) -> void:
	if (get_child(0).powered or get_child(1).powered) and allow_:
		powered = true
		add_to_group("Powered")
	else:
		powered = false
		remove_from_group("Powered")
		
	if get_child(0).directly_powered or get_child(1).directly_powered:
		directly_powered = true
	else:
		directly_powered = false
		
	if get_parent().allow_circuits.is_connected(allow_circuits) == false:
		get_parent().allow_circuits.connect(allow_circuits)
	
	if get_child(0).touching_wire or get_child(1).touching_wire:
		add_to_group("Connected_Wires")
	else:
		remove_from_group("Connected_Wires")
		
	#print(get_tree().get_nodes_in_group("Connected_Wires"))
		
func allow_circuits(condition):
	if condition:
		allow_ = true
	#else:
		#allow_ = false
		
