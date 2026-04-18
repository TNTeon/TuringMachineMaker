extends TuringMaker

@onready var init_machine_pick: initial_machine_picker = $InitialMachinePicker
@onready var save_setting: save_settings = $SaveSettings
@onready var gridObjectTracker: grid_object_tracker = $GrideObjectTracker

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
