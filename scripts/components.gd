extends Control
class_name Components

@export var powered : bool
enum connected { YES, NO }

@onready var module_border: Area2D = $"../Module_Border"

@export var draggable := false
@export var last_pos : Vector2
@export var inside : bool

var centre := size / 2
var mouse_in := false

func _ready() -> void:
	last_pos = position

func _process(delta: float) -> void:
	if draggable and inside:
		position = Vector2(get_global_mouse_position().x - centre.x, get_global_mouse_position().y - centre.y)
	else:
		draggable = false

func _on_mouse_entered():
	mouse_in = true

func _on_mouse_exited() -> void:
	mouse_in = false
