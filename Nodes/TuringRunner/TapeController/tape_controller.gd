class_name tape_controller
extends Control

@export_category("Dependencies")
@export
var TAPE : Tape = null

var machine : TuringMachine

func _ready() -> void:
	assert(TAPE != null)
	machine = TuringStorage.graphMachines["RF"]

func _input(event: InputEvent) -> void:
	var action = machine.singleStep(TAPE.getCurrentIndexValue())
	match (action):
		"R":
			TAPE.moveRight()
		"L":
			TAPE.moveLeft()
		"halt":
			print("Halt")
		_:
			TAPE.setCurrentIndexValue(action)
