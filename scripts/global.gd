extends Node

const LOBBY = preload("res://scenes/rooms/lobby/lobby.tscn")
const ROOM_1 = preload("res://scenes/rooms/room_1.tscn")
const ROOM_2 = preload("res://scenes/rooms/room_2.tscn")
const ROOM_3 = preload("res://scenes/rooms/room_3.tscn")
const ROOM_4 = preload("res://scenes/rooms/room_4.tscn")
const ROOM_5 = preload("res://scenes/rooms/room_5.tscn")
const CHECKPOINT = preload("res://scenes/rooms/checkpoint.tscn")

@onready var room_text: Label = $HUD/Room_Widgets/Room_Text

var room_pool = [ROOM_1, ROOM_2, ROOM_3, ROOM_4, ROOM_5]

var score = 0

var room : int
var currency : int

func _ready() -> void:
	$HUD/Room_Widgets.visible = false
	currency = 0
	$Background_Components/Detection_Areas.next_room.connect(next_room)

func _physics_process(_delta: float) -> void:
	$HUD/Scrap_Widgets/Currency_Text.text = str(Global.score)

func next_room():
	room = room + 1
	room_text.text = "Room " + str(room)
	var randi_room = room_pool.pick_random()
	
	if room != 0:
		$HUD/Room_Widgets.visible = true
	
	## Removes Completed Room from Game Scene
	for child in $Rooms.get_children():
		$Rooms.remove_child(child)

	if room % 10 == 0:
		boss_level()
	elif room % 5 == 0:
		check_point()
	else:
		var new_room = randi_room.instantiate()
		$Rooms.add_child(new_room)
	
func check_point():
	$Rooms.add_child(CHECKPOINT.instantiate())

func boss_level():
	pass

func cycle_finish():
	room = 0
	$Rooms.add_child(LOBBY.instantiate())
	$HUD/Room_Widgets.visible = false
