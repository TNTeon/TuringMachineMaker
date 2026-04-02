class_name grid_object_tracker
extends Node

@export_category("Dependencies")
@export
var grid : moveable_grid = null
@export
var placer : grid_placer = null

var tracked_nodes : Dictionary[Vector2,Node]

signal newNodeTracked

func _on_child_created(node: Node) -> void:
	if node.has_method("selectable"):
		tracked_nodes.set(node.position,node)
		newNodeTracked.emit(node)

func get_node_from_position(pos : Vector2):
	return tracked_nodes.get(pos)
