class_name edge_connection_dialoge
extends CanvasLayer

signal connection_values_given

@onready var line_edit = $Panel/VBoxContainer/Control2/LineEdit

func _ready():
	call_deferred("pauseProgram")
	line_edit.grab_focus()

func pauseProgram():
	get_tree().paused = true

func _on_tree_exiting():
	get_tree().paused = false


func _on_save_pressed() -> void:
	var givenText : String = line_edit.text
	var splitText = givenText.split(",")
	connection_values_given.emit(splitText)
	queue_free()

func _on_cancel_pressed() -> void:
	queue_free()
