class_name Tile
extends Control

var index : int

@onready var rich_text_label = $Panel/CenterContainer/RichTextLabel

func setValue(value):
	rich_text_label.text = str(value)

func getValue():
	return rich_text_label.text
