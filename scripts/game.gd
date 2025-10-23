extends Node

# Index of room decals(as scenes) and scenes for boss and checkpoint levels
const LOBBY = preload("res://scenes/rooms/lobby/lobby.tscn")
const ROOM_1 = preload("res://scenes/rooms/room_1.tscn")
const ROOM_2 = preload("res://scenes/rooms/room_2.tscn")
const ROOM_3 = preload("res://scenes/rooms/room_3.tscn")
const ROOM_4 = preload("res://scenes/rooms/room_4.tscn")
const ROOM_5 = preload("res://scenes/rooms/room_5.tscn")
const CHECKPOINT = preload("res://scenes/rooms/checkpoint.tscn")
const BOSS_LEVEL = preload("res://scenes/rooms/boss_level.tscn")

# Room Playlist Directory
@onready var rooms: Node2D = $Rooms

# Control node HUD information and text displays
@onready var room_text: Label = $HUD/Room_Widgets/Room_Text
@onready var room_widgets: Control = $HUD/Room_Widgets
@onready var currency_text: Label = $HUD/Scrap_Widgets/Currency_Text
@onready var currency_text_unsaved: Label = $HUD/Scrap_Widgets/Currency_Text_Unsaved

# Player reference
@onready var player: Player = $Player

# Black fade transition
@onready var scene_transition := $Scene_Transition/AnimationPlayer

# Reference to the detection areas that the player are prone to collide with
@onready var detection_areas: Area2D = $Background_Components/Detection_Areas

# Current room number
var room : int

# Record of how many levels till the difficulty increases
var difficulty_increase = 0

var room_pool = [ROOM_1, ROOM_2, ROOM_3, ROOM_4, ROOM_5]


func _ready() -> void:
	# Play black fade transition when scene has loaded
	scene_transition.play("fade_out")
	
	# Hides room count display
	room_widgets.visible = false
	
	# Connect a signal that detects when the player has exited the room to change to another in the room pool
	detection_areas.next_room.connect(next_room)


func _physics_process(_delta: float) -> void:
	health_correction()
	health_dependency()
	currency_display()


# Match currency displays with global variables
func currency_display():
	# Ensure once score goes over 99 it will change to +99
	if Global.score >= 99:
		currency_text.text = str("+", 99)	
	else:
		currency_text.text = str(Global.score)
	
	# Ensure one over +99 sets it to ++99
	if Global.unsaved_score >= 99:
		currency_text_unsaved.text = str("++", 99)
	else:
		currency_text_unsaved.text = str("+" , Global.unsaved_score)


# Cause certain actions dependent on player health
func health_dependency():
	# Player will not gain unsaved score into score
	if Global.player_hp <= 0:
		cycle_finish()
		Global.go_back = false
		Global.died = true
	# Player will save score from unsaved score
	elif Global.go_back:
		Global.score += Global.unsaved_score
		cycle_finish()
		Global.go_back = false


# Ensures that the health of the player hp does not exceed the max/min amount it can have
func health_correction():
	if Global.player_max_hp < Global.player_hp:
		Global.player_hp = Global.player_max_hp


# Prepare for next level
func level_change():
	# Resets player position seeming it is entering from the bottom door
	player.position = Vector2(112.0,193.0)
	
	# Removes Completed Room from Game Scene
	for child in rooms.get_children():
		rooms.remove_child(child)


# Play whenever the player touches the detection areas to move to the next room
func next_room():
	level_change()
	difficulty()

	room = room + 1
	
	# Change the display of the Room Counter
	room_text.text = "Room " + str(room)
	var randi_room = room_pool.pick_random()
	
	# Allows the HUD display to show when not lobby
	if room != 0:
		room_widgets.visible = true
	
	# Every 15 levels the boss level will play
	if room % 15 == 0:
		boss_level()
	# Every 5 levels the checkpoint level will play
	elif room % 5 == 0 or room % 10 == 0:
		check_point()
	# Every other next room is a randomised new room from the room pool
	else:
		var new_room = BOSS_LEVEL.instantiate() ##
		rooms.call_deferred("add_child", new_room)


# Record when to change difficulty
func difficulty():
	difficulty_increase += 1
	
	# Increase health, damage and quantity of enemies
	if difficulty_increase == 11:
		Global.enemy_num = [3,5]
		Global.enemy_health += 10
		Global.enemy_damage += 2
		
		# Reset to 1 to ensure it happens the next 10 levels to prevent 11 -> 22 happening (rather 11 -> 21)
		difficulty_increase = 1


# Instantiate the Checkpoint Level
func check_point():
	var checkpoint = CHECKPOINT.instantiate()
	rooms.call_deferred("add_child", checkpoint)


# Instantiate the Boss Level
func boss_level():
	var boss = BOSS_LEVEL.instantiate()
	rooms.call_deferred("add_child", boss)


# Reponsible for lobby reset
func cycle_finish():
	# Ensure to remove all bullets that should not be on the scene when transitioning to the next level
	for node in get_tree().get_nodes_in_group("Bullet"):
		node.queue_free()
	
	# Stop Playing General Combat Music
	SoundBoard.get_node("Fighting_Music").stop()
	
	# When the scene in Rooms resets to lobby, the player health will reset to max
	Global.player_hp = Global.player_max_hp
	Global.player_moveable = true

	difficulty_increase = 0
	level_change()
	# Room Counter Resets to 0
	room = 0
	
	rooms.add_child(LOBBY.instantiate())
	room_widgets.visible = false
	
	# Update Score based on score variable
	currency_text.text = str(Global.score)
	
	Global.unsaved_score = 0
	
	# Reset condition of player returning to lobby because of dying
	Global.died = false
