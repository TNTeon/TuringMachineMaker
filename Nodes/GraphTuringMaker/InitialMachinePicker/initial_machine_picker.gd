class_name initial_machine_picker
extends Sprite2D

@export_category("Dependencies")
@export
var grid : moveable_grid = null
@export
var object_tracker: grid_object_tracker = null

var init_machine : machine_item

func _ready() -> void:
	self.visible = false
	assert(grid != null and object_tracker != null)

func action():
	var gridPos = grid.snapPosToGrid(get_global_mouse_position())
	var node = object_tracker.get_node_from_position(gridPos)
	if node == null:
		return
	self.visible = true
	init_machine = node
	position = node.position
	print("fired")
