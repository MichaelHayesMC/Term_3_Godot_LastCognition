extends CircuitComponent

@onready var wire_collision: ConnectionPoint = $Wire_Collision
@onready var wire_collision_2: ConnectionPoint = $Wire_Collision2
@onready var line_2d: Line2D = $Line2D

# Colour References
var Activated = Color(0.37, 1, 0, 1)
var Deactivated = Color(0.12, 0.14, 0.18, 0.72)


func _ready() -> void:
	# Starts off with both points connected to each point
	line_2d.add_point(wire_collision.position)
	line_2d.add_point(wire_collision_2.position)
	line_2d.modulate = Deactivated


func _process(_delta: float) -> void:
	# Keeps nodes connected to the two points
	line_2d.set_point_position(0, wire_collision.position)
	line_2d.set_point_position(1, wire_collision_2.position)


# Change the visibility of the line to be on
func turn_on_effect():
	line_2d.modulate = Activated


# Change the visibility of the line to be off
func turn_off_effect():
	line_2d.modulate = Deactivated
