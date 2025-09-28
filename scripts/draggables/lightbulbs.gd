class_name TextPrinter 
extends CircuitComponent

@onready var sprite_2d: Sprite2D = $Wire_Collision/Sprite2D
@onready var point_light_2d: PointLight2D = $Wire_Collision/PointLight2D

func turn_on_effect():
	point_light_2d.visible = true
	sprite_2d.material.set_shader_parameter("shader_enabled", false)
	
func turn_off_effect():
	point_light_2d.visible = false
	sprite_2d.material.set_shader_parameter("shader_enabled", true)
	
