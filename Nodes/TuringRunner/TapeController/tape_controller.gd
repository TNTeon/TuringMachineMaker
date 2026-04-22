class_name tape_controller
extends Control

@export_category("Dependencies")
@export
var TAPE : Tape = null

var machine : TuringMachine

func _ready() -> void:
	assert(TAPE != null)

func setMachine(_machine):
	machine = _machine
	machine.reset()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if machine != null:
			runFullMachine()
	elif event.is_action_pressed("ui_left"):
		TAPE.moveLeft()
	elif event.is_action_pressed("ui_right"):
		TAPE.moveRight()
	elif event.is_pressed() and event is InputEventKey:
		TAPE.setCurrentIndexValue(char(event.unicode))

func runFullMachine():
	while singleStep() != "halt":
		await get_tree().create_timer(0.5).timeout

func singleStep():
	var action = machine.singleStep(TAPE.getCurrentIndexValue())
	match (action):
		"R":
			TAPE.moveRight()
		"L":
			TAPE.moveLeft()
		"halt":
			print("Halt")
			return "halt"
		_:
			TAPE.setCurrentIndexValue(action)
