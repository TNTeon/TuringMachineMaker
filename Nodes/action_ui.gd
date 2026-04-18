class_name action_ui
extends Control

@export
var ignoreClicks : Array[Node]

var collapsed : bool = false

var current_action = null
var action_buttons = null

var clicking : Vector2 = Vector2.ZERO
var hovering : bool = false

@onready var animation_player = $AnimationPlayer
@onready var action_button_holder: VBoxContainer = $Panel/Seperator/ActionButtonHolder

func _ready():
	action_buttons = get_tree().get_nodes_in_group("action_buttons")
	for i : action_button in action_buttons:
		i.reparent(action_button_holder)
		i.visible = true
		i.actionPressed.connect(actionChanged)
	for i in ignoreClicks:
		if i != null and i.has_signal("mouse_entered") and i.has_signal("mouse_exited"):
			i.mouse_entered.connect(_mouse_hovering)
			i.mouse_exited.connect(_mouse_unhovering)
		else:
			print("Couldn't connect ignore click")
		
func _input(event: InputEvent):
	if event is InputEventMouseButton and current_action and !hovering:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			clicking = get_viewport().get_mouse_position()
		if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			if get_viewport().get_mouse_position().distance_to(clicking) < 0.5:
				current_action.action()

func _on_collapse_pressed():
	if not animation_player.is_playing():
		if collapsed:
			collapsed = false
			animation_player.play("open_window")
		else:
			collapsed = true
			animation_player.play("close_window")

func actionChanged(connection : Node):
	current_action = connection
	for i : action_button in action_buttons:
		if i.connection != current_action:
			i.un_press()


func _mouse_hovering() -> void:
	hovering = true


func _mouse_unhovering() -> void:
	hovering = false
