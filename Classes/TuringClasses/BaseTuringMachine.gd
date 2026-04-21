class_name BaseTuringMachine

extends TuringMachine
	
var states : Dictionary = {}

var currentState = 0

func createQuad(state : int, reading : String, action : String, next : int) -> bool:
	var actionDict : Dictionary
	actionDict.set("action",action)
	actionDict.set("next",next)
	
	var not_overwriting = true
	var stateDict : Dictionary
	if states.get(state):
		stateDict = states.get(state)
	if stateDict.get(reading):
		not_overwriting = false
		print("WARNING: DATA IS BEING OVERWRITTEN IN TURING MACHINE")
	stateDict.set(reading,actionDict)
	states.set(state,stateDict)
	return not_overwriting
	

func getAction(state,reading):
	var getState = states.get(str(state))
	if getState != null:
		return getState.get(reading)
	return null
	
func saveMachine():
	if name.is_empty():
		return
	var save_file = FileAccess.open(Paths.baseMachines+name+font.font_name[0]+".tur", FileAccess.WRITE)
	
	var save_data : Dictionary
	save_data.set("states",states)
	save_data.set("name",name)
	
	var fontPath = font.to_string().split("<")[0]
	fontPath=fontPath.substr(1, len(fontPath)-3)
	save_data.set("font",fontPath)
	
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
		
		var machine = BaseTuringMachine.new()
		
		machine.states = machine_data["states"]
		machine.name = machine_data["name"]
		machine.font = load(machine_data["font"])
		
		return machine

func singleStep(currentValue):
	var actionDict = getAction(currentState,currentValue)
	print(actionDict)
	if actionDict is Dictionary:
		var action = actionDict["action"]
		currentState = actionDict["next"]
		return action
	else:
		return "halt"
