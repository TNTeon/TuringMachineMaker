extends Node

var base_font_size : int
var base_size : Vector2
var label : RichTextLabel

func _ready():
	call_deferred("setupInit")

func setupInit() -> void:
	# caches initial sizes
	label = get_parent() as RichTextLabel
	base_size = label.size
	base_font_size = label["theme_override_font_sizes/normal_font_size"]
	label.resized.connect(set_text_size)
	
func set_text_size():
	var new_size = label.size

	# scale base on control width
	var scale = new_size.x / base_size.x
	var scaled_size :int= floor(base_font_size * scale)

	# bitmap cannot be greater than 4096
	if scaled_size>4096:
		return

	# apply scale
	label.add_theme_font_size_override("normal_font_size", scaled_size)

func _on_tree_exiting() -> void:
	label.resized.disconnect(set_text_size)
