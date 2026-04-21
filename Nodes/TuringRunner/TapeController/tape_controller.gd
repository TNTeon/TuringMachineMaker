class_name tape_controller
extends Control

@export_category("Dependencies")
@export
var TAPE : Tape = null

var machine : TuringMachine

var status : STATUSES = STATUSES.NO_MACHINE

@onready var start_stop_but = $"../VBox/HboxControlsOrganizer/StartStopBut"
@onready var status_reporter = $"../VBox/HboxStatusOrganizer/StatusBackground/StatusReporter"
@onready var current_reporter = $"../VBox/HboxCurrentOrganizer/CurrentBackground/CurrentReporter"

enum STATUSES {
	RUNNING,
	HALTED,
	PAUSED,
	NO_MACHINE
}

func _ready() -> void:
	assert(TAPE != null)

func setMachine(_machine):
	machine = _machine
	setStatus(STATUSES.PAUSED)
	machine.reset()

func _input(event: InputEvent) -> void:
	if status == STATUSES.RUNNING:
		return
	if event.is_action_pressed("ui_accept"):
		requestPlayOrPause()
	elif event.is_action_pressed("ui_left"):
		TAPE.queueMove(-1)
	elif event.is_action_pressed("ui_right"):
		TAPE.queueMove(1)
	elif event.is_pressed() and event is InputEventKey:
		TAPE.queueWrite(char(event.unicode))

func runFullMachine():
	setStatus(STATUSES.RUNNING)
	while status != STATUSES.PAUSED:
		if (singleStep() != "halt"):
			await get_tree().create_timer(TAPE.speed*2).timeout
		else:
			setStatus(STATUSES.HALTED)
			return

func singleStep():
	var action = machine.singleStep(TAPE.getCurrentIndexValue())
	if machine is GraphTuringMachine and machine.currentMachine != null:
		current_reporter.text = machine.currentMachine.machine.name
	elif machine is BaseTuringMachine:
		current_reporter.text = machine.name
	match (action):
		"R":
			TAPE.queueMove(1)
		"L":
			TAPE.queueMove(-1)
		"halt":
			print("Halt")
			return "halt"
		_:
			TAPE.queueWrite(action)

func requestPlayOrPause():
	if status == STATUSES.RUNNING:
		setStatus(STATUSES.PAUSED)
	elif status == STATUSES.PAUSED:
		runFullMachine();
	elif status == STATUSES.HALTED:
		setMachine(machine)
		runFullMachine()

func setStatus(newStatus : STATUSES):
	status = newStatus
	if status == STATUSES.RUNNING:
		status_reporter.text = "Running"
		start_stop_but.text = "Stop"
	if status == STATUSES.HALTED:
		status_reporter.text = "Halted"
		start_stop_but.text = "Start"
	if status == STATUSES.PAUSED:
		status_reporter.text = "Paused"
		start_stop_but.text = "Start"
	if status == STATUSES.NO_MACHINE:
		status_reporter.text = "No Machine"
		start_stop_but.text = ""


func _on_speed_selector_value_changed(value):
	TAPE.setSpeed((1-value)/2)
