extends Node

var score = 0
var unsaved_score = 0

var player_moveable : bool = true
var player_speed : int = 40
var player_attack : int = 5
var player_hp : int = 100

var go_back = false

var block_dragging := false
var circuit_complete := false

var enemy_num = randi_range(0,1)
var enemy_health := 10
