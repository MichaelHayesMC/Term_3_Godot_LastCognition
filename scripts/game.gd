extends Node

const LOBBY = preload("res://scenes/rooms/lobby/lobby.tscn")
const ROOM_1 = preload("res://scenes/rooms/room_1.tscn")
const ROOM_2 = preload("res://scenes/rooms/room_2.tscn")
const ROOM_3 = preload("res://scenes/rooms/room_3.tscn")
const ROOM_4 = preload("res://scenes/rooms/room_4.tscn")
const ROOM_5 = preload("res://scenes/rooms/room_5.tscn")
const CHECKPOINT = preload("res://scenes/rooms/checkpoint.tscn")
const BOSS_LEVEL = preload("res://scenes/rooms/boss_level.tscn")

@onready var rooms: Node2D = $Rooms
@onready var room_text: Label = $HUD/Room_Widgets/Room_Text
@onready var currency_text: Label = $HUD/Scrap_Widgets/Currency_Text
@onready var currency_text_unsaved: Label = $HUD/Scrap_Widgets/Currency_Text_Unsaved
@onready var player: Player = $Player

var room_pool = [ROOM_1, ROOM_2, ROOM_3, ROOM_4, ROOM_5]

var room : int

func _ready() -> void:
	$HUD/Room_Widgets.visible = false
	$Background_Components/Detection_Areas.next_room.connect(next_room)

func _physics_process(_delta: float) -> void:
	currency_text_unsaved.text = str("+" , Global.unsaved_score)
	
	if Global.score >= 99:
		currency_text.text = str("+", 99)	
	else:
		currency_text.text = str(Global.score)
	
	if Global.go_back:
		cycle_finish()
		Global.go_back = false

func next_room():
	level_change()
	
	room = room + 1
	room_text.text = "Room " + str(room)
	var randi_room = room_pool.pick_random()
	
	if room != 0:
		$HUD/Room_Widgets.visible = true

	if room % 10 == 0:
		boss_level()
	elif room % 5 == 0:
		check_point()
	else:
		var new_room = randi_room.instantiate()
		rooms.add_child(new_room)
	
func check_point():
	rooms.add_child(CHECKPOINT.instantiate())

func boss_level():
	rooms.add_child(BOSS_LEVEL.instantiate())

func cycle_finish():
	Global.player_moveable = true
	level_change()
	room = 0
	rooms.add_child(LOBBY.instantiate())
	$HUD/Room_Widgets.visible = false
	
	Global.score += Global.unsaved_score
	Global.unsaved_score = 0
	currency_text.text = str(Global.score)
	
func level_change():
	player.position = Vector2(112.0,193.0)
	
	## Removes Completed Room from Game Scene
	for child in rooms.get_children():
		rooms.remove_child(child)
