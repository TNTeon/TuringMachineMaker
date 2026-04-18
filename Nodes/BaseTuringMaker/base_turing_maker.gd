extends TuringMaker

@onready var quad_holder: VBoxContainer = $ScrollContainer/List/QuadHolder

const QUAD_MAKER = preload("uid://70bg17qa3lti")

@onready var saveSettings: save_settings = $SaveSettings

func _ready() -> void:
	saveSettings.requestSave.connect(_on_save)

func _on_new_quad_pressed() -> void:
	var newQuad : QuadMaker = QUAD_MAKER.instantiate()
	quad_holder.add_child(newQuad)
	newQuad.request_deletion.connect(_delete_quad.bind(newQuad))
	newQuad.setRow(quad_holder.get_child_count())

func _delete_quad(node : QuadMaker) -> void:
	var nodePos = node.getRow()-1
	for i in range(nodePos + 1, quad_holder.get_child_count()):
		var quad = quad_holder.get_child(i)
		quad.setRow(i)
	node.queue_free()
		

func _on_save() -> void:
	var machine = makeMachine()
	if machine == null:
		return
	if saveSettings.get_machine_name() == null or saveSettings.get_machine_name() == "":
		createPopup("Name Not Set","Please give this machine a name before saving.")
		return
		
	machine.setMachine(saveSettings.get_machine_name(),saveSettings.get_font())
	
	machine.saveMachine()

func makeMachine():
	var machine = BaseTuringMachine.new()
	var counter : int = 0
	for i : QuadMaker in quad_holder.get_children():
		counter += 1
		if  i.quad.get("a0") == "": createPopup("Incomplete Table","Row %s is missing an a0 value." % [counter]); return null
		elif i.quad.get("a1") == "": createPopup("Incomplete Table","Row %s is missing an a1 value." % [counter]); return null
		else:
			if not machine.createQuad(i.quad.get("q0"),i.quad.get("a0"),i.quad.get("a1"),i.quad.get("q1")):
				createPopup("Overwriting Data","Row %s contains the same Initial State and Reading Char as a previous row." % [counter])
				return null
	return machine
