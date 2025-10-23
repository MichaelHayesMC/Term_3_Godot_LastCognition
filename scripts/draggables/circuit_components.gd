class_name CircuitComponent 
extends Node2D

# Constantly saved record of all components that have been checked
static var checked_components : Array[CircuitComponent]

var next_components : Array[CircuitComponent]
var activated := false


# Ensures that the turn on function (effect the bulbs play) blueprint plays once
func turn_on():
	if activated : return
	activated = true
	
	
	## NEED TO LOOK INTO TO MAKE IT ORGANISED
	if self is TextPrinter:
		if self.is_in_group("Lightning"):
			Global.player_speed += 10
		if self.is_in_group("Attack"):
			Global.player_attack += 5
		if self.is_in_group("Defense"):
			Global.player_max_hp += 10


# Ensures that the turn off function (effect the bulbs play) blueprint plays once
func turn_off():
	if not activated : return
	activated = false
	
	
	## NEED TO LOOK INTO TO MAKE IT ORGANISED
	if self is TextPrinter:
		if self.is_in_group("Lightning"):
			Global.player_speed -= 10
		if self.is_in_group("Attack"):
			Global.player_attack -= 5
		if self.is_in_group("Defense"):
			Global.player_max_hp -= 10


# Blueprint for continous effect to apply
func turn_on_effect():
	pass


# Blueprint for continous effect to remove
func turn_off_effect():
	pass


# Checks for the instance when a node is disconnected and will remove that component to the list of powered and checked components
func chain_disconnect(path : Array[CircuitComponent]) -> bool :
	if self is PowerSource:
		return true
	path.append(self)
	for component in next_components:
		if component in path:
			continue
		if component.chain_disconnect(path):
			return true
			
	turn_off()
	turn_off_effect()
	return false


# Checks for the instance when a node is connected and will append that component to the list of powered and checked components - It will create an array to check the pairs between components
func propagate(reset_list : bool = false) -> void:
	if reset_list:
		checked_components = []
	turn_on()
	turn_on_effect()
	for component in next_components:
		if component in checked_components:
			continue
		checked_components.append(component)
		component.propagate()


# Create a pair of the two connecting nodes
func connect_to(component : CircuitComponent):
	if not next_components.find(component) != -1: 
		next_components.append(component)


# Remove pair of connected nodes
func disconnect_from(component : CircuitComponent):
	var index : int = next_components.find(component)
	if index != -1:
		next_components.remove_at(index)
		chain_disconnect([])
