extends CanvasLayer

const MACHINE_PICKER = preload("uid://m18bgotrnj6u")
const GRAPH_TURING_MAKER = preload("uid://hp3hcl3nba2t")


func _ready() -> void:
	var picker : machine_picker = MACHINE_PICKER.instantiate()
	picker.instance_machine_item = false
	picker.machineSelected.connect(func(machine): _on_machine_selected(machine))
	add_child(picker)

func _on_machine_selected(machine):
	call_deferred("loadGraph",machine)

func loadGraph(machine : GraphTuringMachine):
	var graphMaker : GraphMaker = GRAPH_TURING_MAKER.instantiate()
	graphMaker.initMachine = machine
	get_tree().change_scene_to_node(graphMaker)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_machine_selected(null)
