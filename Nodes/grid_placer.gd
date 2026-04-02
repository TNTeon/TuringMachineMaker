class_name grid_placer
extends Node2D

@export_category("Dependencies")
@export
var grid : moveable_grid = null
@export
var node : PackedScene = null

@export_category("Config")
@export
var object_tracker : grid_object_tracker = null

@export
var allowOverlap : bool = false

var active : bool = false

#This feels like a bool, but actually it will track mouse Pos to dertermine
#	if the mouse was clicked or dragged.
var clicking : Vector2 = Vector2.ZERO

func _input(event):
	if active:
		if event is InputEventMouseButton:
			if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
				clicking = get_viewport().get_mouse_position()
			if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
				if get_viewport().get_mouse_position().distance_to(clicking) < 0.5:
					action()

func action():
	checkNulls()
	var placeNode = node.instantiate()
	var mousePos = get_global_mouse_position()
	var snapMouse = grid.snapPosToGrid(mousePos)
	
	if not allowOverlap and is_overlap(snapMouse,get_tree().get_nodes_in_group("onGrid")):
		return
	
	placeNode.add_to_group("onGrid")
	if object_tracker != null:
		object_tracker.add_child(placeNode)
	else:
		grid.add_child(placeNode)
	placeNode.position = grid.snapPosToGrid(mousePos)

func is_overlap(pos, group):
	for i in group:
		if i.position == pos:
			return true
	return false

func checkNulls():
	assert(grid != null, "Class relies on a grid")
	assert(node != null, "Class relies on a provided Scene to place")
