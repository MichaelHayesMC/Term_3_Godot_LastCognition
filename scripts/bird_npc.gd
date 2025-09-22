extends CharacterBody2D

func _ready() -> void:
	$"../PurchaseMenu".visible = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Sprite2D.visible = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$Sprite2D.visible = false

func _physics_process(_delta: float) -> void:
	if $Sprite2D.visible and Input.is_action_just_pressed("interact"):
		$"../PurchaseMenu".visible = true
	
	var inputs = ["down", "up", "left", "right"]
	
	for input in inputs:
		if Input.is_action_pressed("move_" + input):
			$"../PurchaseMenu".visible = false
