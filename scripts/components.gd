extends Node2D
class_name Components

@export var powered : bool
enum connected { YES, NO }

@onready var module_border: Area2D = $Module_Border

@export var draggable := false
@export var last_pos : Vector2
@export var inside : bool

var mouse_in := false
var carrying : bool

func _ready() -> void:
	last_pos = position

func _process(delta: float) -> void:
	if draggable and inside:
		position = get_global_mouse_position()
	else:
		draggable = false
