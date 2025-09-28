extends Node2D

@onready var power_start: CircuitComponent = $Power/PowerStart

func _on_timer_timeout() -> void:
	CircuitComponent.checked_components = [] 
	power_start.propagate()
