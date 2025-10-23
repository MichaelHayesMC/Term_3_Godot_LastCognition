extends Node2D

# Reference on what the gun will be shooting out
@export var _bullet_scene : PackedScene

# Where the bullets will be spawning from on the gun
@onready var bullet_spawn: Marker2D = $Marker2D

@onready var gun_texture: Sprite2D = $GunTexture
@onready var shoot_cd: Timer = $Shoot_CD

var mouse_pos : Vector2
var idk : int
var shootable := true


# Create a new bullet facing in the direction of the gun
func fire():
	var bullet = _bullet_scene.instantiate()
	bullet.position = bullet_spawn.global_position
	bullet.direction = bullet_spawn.global_position - global_position
	get_tree().get_root().add_child(bullet)
	
	# Play gun firing sound
	SoundBoard.get_node("Shoot").play()


func _physics_process(_delta: float) -> void:
	# Change the direction of the gun to face the mouse cursor
	mouse_pos = get_global_mouse_position()
	look_at(Vector2(mouse_pos.x, mouse_pos.y))
	
	player_input()


func player_input():
	# Only shoots when a circuit is completed by connecting the wires to the power end component and after cooldown
	if Input.is_action_pressed("click_left") and shootable and Global.circuit_complete:
		# Only allow the player to shoot when mouse is on the game section and not the circuit modifiction seciton
		if !mouse_pos.x > 216:
			shoot_cd.start()
			fire()
			shootable = false


func _on_timer_timeout() -> void:
	shootable = true
