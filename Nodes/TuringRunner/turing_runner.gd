extends Control

@onready var tapeController: tape_controller = $TapeController
@onready var title = $VBox/HBoxTopOrganizer/TitleBackground/Title

const MACHINE_PICKER = preload("uid://m18bgotrnj6u")

func _on_select_machine_pressed() -> void:
	var picker : machine_picker = MACHINE_PICKER.instantiate()
	picker.instance_machine_item = false
	picker.machineSelected.connect(func(machine): _on_machine_selected(machine))
	add_child(picker)

func _on_machine_selected(machine : TuringMachine):
	tapeController.setMachine(machine)
	title.text = machine.name

func _on_exit_but_pressed():
	get_tree().change_scene_to_file("res://Nodes/SceneNavigator/SceneNavigaor.tscn")
