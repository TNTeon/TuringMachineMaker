extends Control

@onready var tapeController: tape_controller = $TapeController

const MACHINE_PICKER = preload("uid://m18bgotrnj6u")


func _on_select_machine_pressed() -> void:
	var picker : machine_picker = MACHINE_PICKER.instantiate()
	picker.instance_machine_item = false
	picker.machineSelected.connect(func(machine): tapeController.setMachine(machine))
	add_child(picker)
