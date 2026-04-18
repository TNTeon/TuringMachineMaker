class_name save_settings
extends Node

signal requestSave
signal requestExit
signal fontChanged
signal nameChanged
signal mouse_entered
signal mouse_exited

const FORMAL_SCRIPT = preload("uid://c8uuavmtut674")
const OPEN_SANS_SEMI_BOLD = preload("uid://qt46wgqoqwhw")

@onready var lineEditName: LineEdit = $Name
@onready var font_selector: Button = $FontSettings/HBoxContainer/FontSelector

func _ready() -> void:
	fontChanged.connect(set_font)
	set_font(FORMAL_SCRIPT)
	for i in get_all_children(self):
		if i is Control:
			i.mouse_entered.connect(mouse_entered.emit)
			i.mouse_exited.connect(mouse_exited.emit)

func get_all_children(in_node,arr:=[]):
	arr.push_back(in_node)
	for child in in_node.get_children():
		arr = get_all_children(child,arr)
	return arr

func get_machine_name():
	return lineEditName.text

func get_font():
	return lineEditName["theme_override_fonts/font"]

func set_font(selectedFont : Font):
	lineEditName.add_theme_font_override("font",selectedFont)
	lineEditName.add_theme_font_size_override("font_size",50)

func _name_changed(new_text: String) -> void:
	nameChanged.emit(new_text)

func _on_save_but_pressed() -> void:
	requestSave.emit()
	
func _on_exit_but_pressed() -> void:
	requestExit.emit()

func _on_font_selector_pressed() -> void:
	if get_font() == FORMAL_SCRIPT:
		set_font(OPEN_SANS_SEMI_BOLD)
		font_selector.text = "Standard"
	else:
		set_font(FORMAL_SCRIPT)
		font_selector.text = "Formal"
