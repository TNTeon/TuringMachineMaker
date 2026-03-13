class_name TuringMachine
	
var states : Dictionary = {}

var name : String = ""

func setName(_name : String):
	name = _name

func createQuad(state, reading, action, next):
	var actionDict : Dictionary
	actionDict.set("action",action)
	actionDict.set("next",next)
	
	var stateDict : Dictionary
	if states.get(state):
		stateDict = states.get(state)
	if stateDict.get(reading):
		print("WARNING: DATA IS BEING OVERWRITTEN IN TURING MACHINE")
	stateDict.set(reading,actionDict)
	
	states.set(state,stateDict)

func getAction(state,reading):
	var getState = states.get(state)
	if getState != null:
		return getState.get(reading)
	return null
	
func saveMachine():
	if name.is_empty():
		return
	if not DirAccess.dir_exists_absolute("user://baseMachines//"):
		DirAccess.make_dir_absolute("user://baseMachines//")
	var save_file = FileAccess.open("user://baseMachines//"+name+".tur", FileAccess.WRITE)
	
	var save_data : Dictionary
	save_data.set("states",states)
	save_data.set("name",name)
	
	var json_string = JSON.stringify(save_data)
	
	save_file.store_line(json_string)
	
static func loadMachine(path):
	if not FileAccess.file_exists(path):
		print("COULD NOT FIND MACHINE TO LOAD")
		return # Error! We don't have a save to load.
		
	var save_file = FileAccess.open(path, FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		
		var json = JSON.new()
		
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
			
		var machine_data = json.data
		
		var machine = TuringMachine.new()
		
		machine.states = machine_data["states"]
		machine.name = machine_data["name"]
		
		return machine
