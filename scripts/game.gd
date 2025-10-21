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
@onready var scene_transition := $Scene_Transition/AnimationPlayer

var room_pool = [ROOM_1, ROOM_2, ROOM_3, ROOM_4, ROOM_5]
var room : int
var difficulty_increase = 0

func _ready() -> void:
	scene_transition.play("fade_out")
	
	$HUD/Room_Widgets.visible = false
	$Background_Components/Detection_Areas.next_room.connect(next_room)

func _physics_process(_delta: float) -> void:
	if Global.player_max_hp < Global.player_hp:
		Global.player_hp = Global.player_max_hp
	
	for child in $Rooms.get_children():
		if child.name == "Lobby":
			Global.player_hp = Global.player_max_hp
	
	if Global.player_hp <= 0:
		Global.player_hp = 0
		Global.died = true
	
	currency_text_unsaved.text = str("+" , Global.unsaved_score)
	
	if Global.score >= 99:
		currency_text.text = str("+", 99)	
	else:
		currency_text.text = str(Global.score)
	
	if Global.player_hp <= 0:
		cycle_finish()
		Global.go_back = false
		Global.died = true
	elif Global.go_back:
		Global.score += Global.unsaved_score
		print(Global.score)
		cycle_finish()
		Global.go_back = false

func next_room():
	level_change()
	
	difficulty_increase += 1
	
	room = room + 1
	room_text.text = "Room " + str(room)
	var randi_room = room_pool.pick_random()
	
	if room != 0:
		$HUD/Room_Widgets.visible = true
	
	if difficulty_increase == 11:
		Global.enemy_num = randi_range(3,4)
		Global.enemy_health += 10
		Global.enemy_damage += 2
		difficulty_increase = 1
	
	if room % 20 == 0:
		boss_level()
	elif room % 5 == 0 or room % 10 == 0:
		check_point()
	else:
		var new_room = BOSS_LEVEL.instantiate() ##
		rooms.add_child(new_room)
	
func check_point():
	rooms.add_child(CHECKPOINT.instantiate())

func boss_level():
	rooms.add_child(BOSS_LEVEL.instantiate())

func cycle_finish():
	for node in get_tree().get_nodes_in_group("Bullet"):
		node.queue_free()
		
	Global.player_moveable = true
	difficulty_increase = 0
	level_change()
	room = 0
	rooms.add_child(LOBBY.instantiate())
	$HUD/Room_Widgets.visible = false
	
	#if !Global.died:
		#Global.score += Global.unsaved_score
		#print(Global.score)
	
	currency_text.text = str(Global.score)
	Global.unsaved_score = 0
	Global.died = false
	
func level_change():
	player.position = Vector2(112.0,193.0)
	
	## Removes Completed Room from Game Scene
	for child in rooms.get_children():
		rooms.remove_child(child)
