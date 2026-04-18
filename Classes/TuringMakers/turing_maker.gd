@abstract
class_name TuringMaker
extends Node

const INFORMATION_POPUP = preload("uid://b3oaj1dbuq4dv")

@abstract
func _on_save()

func createPopup(title,info):
	var popup : InformationPopup = INFORMATION_POPUP.instantiate()
	add_child(popup)
	popup.setText(title,info)
