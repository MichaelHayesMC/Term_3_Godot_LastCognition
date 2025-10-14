extends Label

func _ready() -> void:
	text = "lAST cOGNITION"

func _on_timer_timeout() -> void:
	text = "lAST cOGNITION_"

func _on_timer_2_timeout() -> void:
	text = "lAST cOGNITION"
