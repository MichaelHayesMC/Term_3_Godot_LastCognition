class_name CircuitComponent 
extends Node2D

static var checked_components : Array[CircuitComponent]

var activated := false

var next_components : Array[CircuitComponent]

func turn_on():
	if activated : return
	activated = true
	print("I'm ", name, " and I just got turned on")
	
	if self is TextPrinter:
		if str(self.name)[0] == "L":
			Global.player_speed += 10
		if str(self.name)[0] == "A":
			Global.player_attack += 5
		if str(self.name)[0] == "D":
			Global.player_hp += 0
	
func turn_off():
	if not activated : return
	activated = false
	print("I'm ", name, " and I just got turned off")
	
	if self is TextPrinter:
		if str(self.name)[0] == "L":
			Global.player_speed -= 10
		if str(self.name)[0] == "A":
			Global.player_attack -= 5
		if str(self.name)[0] == "D":
			Global.player_hp -= 0
		

func turn_on_effect():
	pass
	
func turn_off_effect():
	pass

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

func connect_to(component : CircuitComponent):
	if not next_components.find(component) != -1: 
		next_components.append(component)

	
func disconnect_from(component : CircuitComponent):
	var index : int = next_components.find(component)
	if index != -1:
		next_components.remove_at(index)
		chain_disconnect([])
