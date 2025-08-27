extends Line2D

@onready var power_source: ColorRect = $"../Power_Source"
@onready var power_source_3: ColorRect = $"../Power_Source3"

var left_side := Vector2.ZERO
var right_side := Vector2.ZERO

func _ready() -> void:
	left_side = power_source.size
	right_side = power_source_3.size
	add_point(left_side, 0)
	add_point(right_side, 1)

func _physics_process(delta: float) -> void:
	left_side = (power_source.size / 2 + power_source.position)
	right_side = (power_source_3.size / 2 + power_source_3.position)
	set_point_position(0, left_side)
	set_point_position(1, right_side)
