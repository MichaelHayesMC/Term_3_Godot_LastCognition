extends CharacterBody2D

@onready var purchase_menu: Node2D = $"../PurchaseMenu"
@onready var interact_prompt_texture: Sprite2D = $InteractPromptTexture

# Sound Effect Reference
@onready var menu_open: AudioStreamPlayer = $Menu_Open


func _ready() -> void:
	# Ensure the purchase menu is invisible on scene load
	purchase_menu.visible = false


# Looks for player to make the "e" interact prompt show
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		interact_prompt_texture.visible = true


# Looks for player to make the "e" interact prompt invisible
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		interact_prompt_texture.visible = false


func _physics_process(_delta: float) -> void:
	# Only show shop menu when player is close enough
	if interact_prompt_texture.visible and Input.is_action_just_pressed("interact"):
		purchase_menu.visible = true
		
		# Check if player is not moving
		if Global.player_moving == false:
			menu_open.play()
	
	menu_close()


# Menu will close when player starts to move
func menu_close():
	var inputs = ["down", "up", "left", "right"]
	
	for input in inputs:
		if Input.is_action_pressed("move_" + input):
			purchase_menu.visible = false
