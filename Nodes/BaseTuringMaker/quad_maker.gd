class_name QuadMaker
extends Panel

@onready var q_0: SpinBox = $hBox/q0
@onready var a_0: LineEdit = $hBox/a0
@onready var a_1: LineEdit = $hBox/a1
@onready var q_1: SpinBox = $hBox/q1

@onready var row_number: RichTextLabel = $hBox/VBoxContainer/RowNumber

signal request_deletion

var quad = {}

func _ready() -> void:
	quad.set("q0",0)
	quad.set("q1",-1)
	quad.set("a0","")
	quad.set("a1","")

func _on_q_0_value_changed(value: float) -> void:
	quad.set("q0",int(value))

func _on_a_0_text_changed(new_text: String) -> void:
	quad.set("a0",new_text)

func _on_a_1_text_changed(new_text: String) -> void:
	quad.set("a1",new_text)

func _on_q_1_value_changed(value: float) -> void:
	quad.set("q1",int(value))

func setRow(rowNum : int):
	row_number.text = "Row %d" % rowNum

func getRow():
	return int(row_number.text)

func _on_remove_pressed() -> void:
	request_deletion.emit()
