class_name machine_connector
extends Node2D

const EDGE_CONNECTION_DIALOGE = preload("uid://brmbhg0novisv")

@export_category("Dependencies")
@export
var grid : moveable_grid = null
@export
var object_tracker: grid_object_tracker = null

var selectedObject : Node = null

func _ready() -> void:
	assert(grid != null and object_tracker != null)
	object_tracker.newNodeTracked.connect(onNewNodeTracked)

func onNewNodeTracked(node : Node2D):
	var leftObj = object_tracker.get_node_from_position(node.position - Vector2(grid.GRID_DISTANCE,0))
	var rightObj = object_tracker.get_node_from_position(node.position + Vector2(grid.GRID_DISTANCE,0))
	if leftObj != null:
		completeConnection([""],leftObj,node)
	if rightObj != null:
		completeConnection([""],node,rightObj)

func action():
	var gridPos = grid.snapPosToGrid(get_global_mouse_position())
	var node = object_tracker.get_node_from_position(gridPos)
	if node == null:
		return
		
	if selectedObject == null:
		selectedObject = node
		node.selectable()
	elif node == selectedObject:
		selectedObject = null
		node.unselect()
	else:
		selectedObject.unselect()
		startConnection(selectedObject, node)
		selectedObject = null

func startConnection(fromNode, toNode):
	var newEdge : edge_connection_dialoge = EDGE_CONNECTION_DIALOGE.instantiate()
	newEdge.connection_values_given.connect(completeConnection.bind(fromNode, toNode))
	add_child(newEdge)

func completeConnection(values : Array[String], fromNode : machine_item, toNode : machine_item):
	fromNode.connection(toNode,values)
