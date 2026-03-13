class_name TuringMachine
	
var states : Dictionary = {}

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
