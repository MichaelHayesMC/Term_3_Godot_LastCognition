extends Label


# Following plays the animation of the main title label removing and adding the underscore
func _ready() -> void:
	text = "lAST cOGNITION"

func _on_timer_timeout() -> void:
	text = "lAST cOGNITION_"

func _on_timer_2_timeout() -> void:
	text = "lAST cOGNITION"
