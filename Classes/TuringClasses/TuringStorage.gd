extends Node

var baseMachines : Dictionary[String,BaseTuringMachine]

func _ready() -> void:
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
