class_name InformationPopup
extends CanvasLayer

@onready var title: RichTextLabel = $Panel/VBoxContainer/TitleText
@onready var info: RichTextLabel = $Panel/VBoxContainer/InfoText

func setText(title_text,info_text):
	title.text = title_text
	info.text = info_text

func _on_button_pressed() -> void:
	queue_free()
