extends Node

var score = 0
var unsaved_score = 0

var player_moveable : bool = true
var player_speed : int = 35
var player_attack : int = 3
var player_mvoing : bool = false

var player_hp : int = 100
var player_max_hp : int = 100

var go_back = false
var died := false

var block_dragging := false
var circuit_complete := false

var enemy_num = randi_range(2,4)
var enemy_health := 10
var enemy_damage := 10

var room_completable := false

var player_dodging := false
