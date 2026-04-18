class_name GraphTuringMachine

extends TuringMachine

var initialMachine : machine_item
var machineItems : Array[machine_item]

const MACHINE_ITEM = preload("uid://b6eabv6jdk1oi")

func _init(_init_machine, _machines) -> void:
	machineItems = _machines
	initialMachine = _init_machine

func saveMachine():
	if name.is_empty():
		return
	var save_file = FileAccess.open(Paths.graphMachines+name+font.font_name[0]+".tur", FileAccess.WRITE)
	
	var save_data : Dictionary
	save_data.set("name",name)
	
	var saved_machines : Dictionary
	for machineItem : machine_item in machineItems:
		saved_machines.set(machineItem.get_instance_id(),machineItem.save())
	save_data.set("machines",saved_machines)
	
	var fontPath = font.to_string().split("<")[0]
	fontPath=fontPath.substr(1, len(fontPath)-3)
	save_data.set("font",fontPath)
	
	save_data.set("init",str(initialMachine.get_instance_id()))
	
	var json_string = JSON.stringify(save_data)
	
	save_file.store_line(json_string)

static func loadMachine(path):
	if not FileAccess.file_exists(path):
		print("COULD NOT FIND MACHINE TO LOAD")
		return # Error! We don't have a save to load.
		
	var save_file = FileAccess.open(path, FileAccess.READ)
	var json_string = save_file.get_line()
	
	var json = JSON.new()
	
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
		
	var machine_data = json.data
	
	var machineDict : Dictionary = machine_data["machines"]
	var allMachineItems : Dictionary[String,machine_item]
	for id in machineDict.keys(): # create items
		var subMachineData : Dictionary = machineDict[id]
		var subNachineInit : TuringMachine
		if subMachineData["type"] == "base":
			subNachineInit = TuringStorage.baseMachines.get(subMachineData["full_name"])
		if subMachineData["type"] == "graph":
			subNachineInit = TuringStorage.getOrLoadGraph(subMachineData["full_name"])
		var item : machine_item = MACHINE_ITEM.instantiate()
		item.machine = subNachineInit
		item.position = Vector2(subMachineData["pos_x"],subMachineData["pos_y"])
		item.path.machineItem = item
		allMachineItems.set(id,item)
	for id in machineDict.keys(): # make connections
		var subMachineItem : machine_item = allMachineItems[id]
		var connectionDict : Dictionary = machineDict[id]["connections"]
		for connection in connectionDict.keys():
			subMachineItem.path.nextMachine.set(connection,allMachineItems[connectionDict[connection]])
	
	var machine : GraphTuringMachine = GraphTuringMachine.new(allMachineItems[machine_data["init"]],allMachineItems.values())
	
	machine.name = machine_data["name"]
	machine.font = load(machine_data["font"])
	
	return machine
