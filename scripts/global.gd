extends Node

var score = 0
var unsaved_score = 0

var player_moveable : bool = true
var player_speed : int = 35
var player_attack : int = 3
var player_moving : bool = false

var player_hp : int = 100
var player_max_hp : int = 100

# State of player going back to the lobby room
var go_back = false
var died := false

# Required for component states
var block_dragging := false
var circuit_complete := false

# Enemy randomisation odds/probability
var enemy_num = [2,3]
var enemy_health := 10
var enemy_damage := 10

# Will ensure that the room doesn't accidently finish
var room_completable := false

var player_dodging := false
