extends Node2D

@onready var power_start: CircuitComponent = $Power/PowerStart


# Acts like a process function that continously checks for nodes connected to powered nodes and stores them into an array
func _on_timer_timeout() -> void:
	CircuitComponent.checked_components = [] 
	power_start.propagate()
