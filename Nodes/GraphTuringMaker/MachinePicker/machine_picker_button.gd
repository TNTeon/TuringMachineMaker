class_name MachinePickerButton
extends Button

signal machineSelected

var machine : BaseTuringMachine

func _ready() -> void:
	text = machine.name
	add_theme_font_override("font",machine.font)

func setHover():
	grab_focus()

func _on_pressed() -> void:
	machineSelected.emit(machine)
