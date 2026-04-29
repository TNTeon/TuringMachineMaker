class_name GraphMaker
extends TuringMaker

@onready var init_machine_pick: initial_machine_picker = $InitialMachinePicker
@onready var save_setting: save_settings = $SaveSettings
@onready var gridObjectTracker: grid_object_tracker = $GrideObjectTracker
var initMachine : GraphTuringMachine = null

func _ready() -> void:
	if initMachine != null:
		loadGraph()

func loadGraph():
	for i in initMachine.machineItems:
		gridObjectTracker.add_child(i)
		if i == initMachine.initialMachine:
			init_machine_pick.setInitialMachine(i)
	save_setting.lineEditName.text = initMachine.name

func _on_save() -> void:
	var init_machine = init_machine_pick.init_machine
	if init_machine == null:
		createPopup("Initial Machine Not Set","Please use the circle tool to select a starting machine.")
		return
	var machine = GraphTuringMachine.new(init_machine,gridObjectTracker.tracked_nodes.values())
	if save_setting.get_machine_name() == null or save_setting.get_machine_name() == "":
		createPopup("Name Not Set","Please give this machine a name before saving.")
		return
		
	machine.setMachine(save_setting.get_machine_name(),save_setting.get_font())
	
	machine.saveMachine()


func _on_save_settings_request_exit() -> void:
	TuringStorage._ready()
	get_tree().change_scene_to_file("res://Nodes/SceneNavigator/SceneNavigaor.tscn")
