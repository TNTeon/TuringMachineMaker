class_name machine_item
extends Node2D

@export var selectedColor : Color = Color.GOLD

var defaultColor : Color

var machine : TuringMachine

var path : MachinePath = MachinePath.new()

@onready var name_label: RichTextLabel = $NameLabel
@onready var sprite: Sprite2D = $Sprite
const OPEN_SANS_SEMI_BOLD = preload("uid://qt46wgqoqwhw")

func _ready() -> void:
	path.machine = self
	name_label.text = machine.name
	name_label.add_theme_font_override("normal_font",machine.font)
	defaultColor = sprite.self_modulate

func _draw() -> void:
	var plannedString = {}
	for i in path.nextMachine.keys():
		var currentValue = path.nextMachine[i]
		if plannedString.has(currentValue):
			plannedString[currentValue] = plannedString[currentValue] + ", " + i
		else:
			plannedString.set(currentValue,i)
	for i in plannedString.keys():
		var from = Vector2.ZERO
		var to = to_local(i.global_position)
		var halfPoint = (from+to)/2
		var difference = from-to
		var angle = atan2(difference.y,difference.x)
		var arrow_angles = [angle + 0.8,angle-0.8]
		var ARROW_LENGTH = 25
		var arrow_pos_rel = [ARROW_LENGTH * Vector2(cos(arrow_angles[0]),sin(arrow_angles[0])),ARROW_LENGTH * Vector2(cos(arrow_angles[1]),sin(arrow_angles[1]))]
		draw_line(from,to,Color.ALICE_BLUE,10)
		draw_line(halfPoint*0.8,arrow_pos_rel[0] + halfPoint*0.8,Color.ALICE_BLUE,10)
		draw_line(halfPoint*0.8,arrow_pos_rel[1] + halfPoint*0.8,Color.ALICE_BLUE,10)
		draw_string(OPEN_SANS_SEMI_BOLD,halfPoint,plannedString[i],HORIZONTAL_ALIGNMENT_CENTER,-1,20, Color.BLACK)

func selectable():
	sprite.self_modulate = selectedColor
	
func unselect():
	sprite.self_modulate = defaultColor

func connection(nextMachinePath : machine_item, pathValue : Array[String]):
	if "" in path.nextMachine:
		path.nextMachine.clear()
	if "" in pathValue:
		path.nextMachine.clear()
		path.nextMachine.set("",nextMachinePath)
	else:
		for i in pathValue:
			path.nextMachine.set(i,nextMachinePath)
	queue_redraw()
