extends Node

var baseMachines : Dictionary[String,TuringMachine]

func _ready() -> void:
	if not DirAccess.dir_exists_absolute(Paths.baseMachines):
		DirAccess.make_dir_absolute(Paths.baseMachines)
	var files = DirAccess.get_files_at(Paths.baseMachines)
	
	for file in files:
		if not file.contains(".tur"):
			pass
		var machine = TuringMachine.loadMachine(Paths.baseMachines+file)
		baseMachines.set(machine.name, machine)
	
	print(baseMachines)
	
func request_late_addition(machine : TuringMachine):
	baseMachines.set(machine.name,machine)

func request_deletion(machine : TuringMachine):
	baseMachines.erase(machine.name)
