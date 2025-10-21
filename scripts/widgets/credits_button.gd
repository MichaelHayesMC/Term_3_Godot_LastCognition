extends TitleScreenButtons

# References to make visible or invisible
@onready var main_page: Control = $".."
@onready var credits_page: Control = $"../../Credits_Page"


# PLays when given a click input from left mouse click
func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
	
			# Play Button Clicked Sound effect
			SoundBoard.get_node("Button_Sfx").play()

			visibility_change()

# Make current nodes invisible and next nodes visible for transition
func visibility_change():
	main_page.visible = false
	credits_page.visible = true
