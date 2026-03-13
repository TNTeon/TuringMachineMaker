extends CanvasLayer

@onready var machineName: LineEdit = $Name
@onready var quad_holder: VBoxContainer = $ScrollContainer/List/QuadHolder

const QUAD_MAKER = preload("uid://70bg17qa3lti")
const INFORMATION_POPUP = preload("uid://b3oaj1dbuq4dv")

const FORMAL_SCRIPT = preload("uid://c8uuavmtut674")
const OPEN_SANS_SEMI_BOLD = preload("uid://qt46wgqoqwhw")

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
	if machineName.text == null or machineName.text == "":
		createPopup("Name Not Set","Please give this machine a name before saving.")
		return
		
	print(machineName["theme_override_fonts/font"])
	machine.setMachine(machineName.text,machineName["theme_override_fonts/font"])
	
	machine.saveMachine()

func makeMachine():
	var machine = TuringMachine.new()
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

func createPopup(title,info):
	var popup : InformationPopup = INFORMATION_POPUP.instantiate()
	add_child(popup)
	popup.setText(title,info)


func _on_font_selected(index):
	match index:
		0:
			machineName.add_theme_font_override("font",FORMAL_SCRIPT)
			machineName.add_theme_font_size_override("font_size",50)
		1:
			machineName.add_theme_font_override("font",OPEN_SANS_SEMI_BOLD)
			machineName.add_theme_font_size_override("font_size",30)
