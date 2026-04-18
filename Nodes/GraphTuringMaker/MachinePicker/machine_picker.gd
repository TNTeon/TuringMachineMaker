extends CanvasLayer
const MACHINE_PICKER_BUTTON = preload("uid://dw26vxsu4hpmt")
const MACHINE_ITEM = preload("uid://b6eabv6jdk1oi")
@onready var base_button_container: VBoxContainer = $Panel/VBoxContainer/ScrollContainer/VBoxForScroll/BaseVsCustom/BaseMachines/BaseButtonContainer
@onready var custom_button_container: VBoxContainer = $Panel/VBoxContainer/ScrollContainer/VBoxForScroll/BaseVsCustom/CustomMachines/CustomButtonContainer

var position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("pauseGame")
	for i : BaseTuringMachine in TuringStorage.baseMachines.values():
		var newButton : MachinePickerButton = MACHINE_PICKER_BUTTON.instantiate()
		newButton.machine = i
		newButton.machineSelected.connect(machine_selected)
		base_button_container.add_child(newButton)
	for i : GraphTuringMachine in TuringStorage.graphMachines.values():
		var newButton : MachinePickerButton = MACHINE_PICKER_BUTTON.instantiate()
		newButton.machine = i
		newButton.machineSelected.connect(machine_selected)
		custom_button_container.add_child(newButton)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = false
		queue_free()

func pauseGame():
	get_tree().paused = true

func machine_selected(machine):
	var newMachineItem : machine_item = MACHINE_ITEM.instantiate()
	newMachineItem.position = position
	newMachineItem.machine = machine
	get_parent().add_child(newMachineItem)
	get_tree().paused = false
	queue_free()

func _on_search_text_changed(new_text: String) -> void:
	for i : MachinePickerButton in base_button_container.get_children():
		if i.text.contains(new_text) or new_text.is_empty():
			i.visible = true
		else:
			i.visible = false
