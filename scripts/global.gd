extends Node

const LOBBY = preload("res://scenes/lobby.tscn")
const ROOM_1 = preload("res://scenes/room_1.tscn")
const ROOM_2 = preload("res://scenes/room_2.tscn")
const ROOM_3 = preload("res://scenes/room_3.tscn")
const ROOM_4 = preload("res://scenes/room_4.tscn")
const ROOM_5 = preload("res://scenes/room_5.tscn")

var room_pool = [ROOM_1, ROOM_2, ROOM_3, ROOM_4, ROOM_5]

var room
var currency : int

func _ready() -> void:
	room = 0
	currency = 0
	$Background_Components/Detection_Areas.next_room.connect(next_room)
	
func next_room():
	for child in $Rooms.get_children():
		$Rooms.remove_child(child)
	
	var randi_room = room_pool.pick_random()
	var new_room = randi_room.instantiate()
	$Rooms.add_child(new_room)
	
	
func cycle_finish():
	room = 0
