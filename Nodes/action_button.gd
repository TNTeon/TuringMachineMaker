class_name action_button
extends TextureButton

@export
var connection : Node = null

signal actionPressed

func _on_pressed() -> void:
	if button_pressed:
		custom_minimum_size = size
		actionPressed.emit(connection)
	else:
		custom_minimum_size = Vector2.ZERO
		actionPressed.emit(null)

func un_press():
	button_pressed = false
