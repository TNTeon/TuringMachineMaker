extends Node

var baseMachines : Dictionary[String,BaseTuringMachine]
var graphMachines : Dictionary[String,GraphTuringMachine]

func _ready() -> void:
	loadBaseMachines()
	loadGraphMachines()
	print("loaded")

var _graphFiles : Array
func loadGraphMachines():
	if not DirAccess.dir_exists_absolute(Paths.graphMachines):
		DirAccess.make_dir_absolute(Paths.graphMachines)
	var files = DirAccess.get_files_at(Paths.graphMachines)
	for file in files:
		print(file)
		if not file.contains(".tur"):
			print("passed,{file}")
			pass
		_graphFiles.append(file)
	for file : String in _graphFiles:
		var name = file.replace(".tur","")
		if not graphMachines.has(name):
			loadSpecificGraph(name)

func loadSpecificGraph(name : String):
	var machine = GraphTuringMachine.loadMachine(Paths.graphMachines+name+".tur")
	graphMachines.set(machine.name+machine.font.font_name[0], machine)

func loadBaseMachines():
	if not DirAccess.dir_exists_absolute(Paths.baseMachines):
		DirAccess.make_dir_absolute(Paths.baseMachines)
	var files = DirAccess.get_files_at(Paths.baseMachines)
	
	for file in files:
		print(file)
		if not file.contains(".tur"):
			print("passed,{file}")
			pass
		var machine = BaseTuringMachine.loadMachine(Paths.baseMachines+file)
		baseMachines.set(machine.name+machine.font.font_name[0], machine)
	print(baseMachines)

func request_late_addition(machine : BaseTuringMachine):
	baseMachines.set(machine.name,machine)

func request_deletion(machine : BaseTuringMachine):
	baseMachines.erase(machine.name)

func getOrLoadGraph(name : String):
	var fromDict = graphMachines.get(name)
	while fromDict == null:
		loadSpecificGraph(name)
		fromDict = graphMachines.get(name)
	return fromDict
	
