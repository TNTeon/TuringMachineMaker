class_name camera_controller
extends Camera2D

const ZOOM_AMOUNT = 0.93
const MAX_ZOOM = 10
const MIN_ZOOM = 0.1

var dragging = false
var mouseTracker = Vector2(0,0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = true
			mouseTracker = get_local_mouse_position()
			
		if event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			dragging = false
		
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom_camera(true)
			
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom_camera(false)
			
		zoom = clamp(zoom,Vector2(MIN_ZOOM,MIN_ZOOM),Vector2(MAX_ZOOM,MAX_ZOOM))
		
	if event is InputEventMouse and dragging:
		update_camera_position()

func update_camera_position():
	var oldMousePos = mouseTracker
	mouseTracker = get_local_mouse_position()
	var deltaPos = mouseTracker - oldMousePos
	position -= deltaPos
	
func zoom_camera(zoomIn = true):
	var zoomVector = Vector2(ZOOM_AMOUNT,ZOOM_AMOUNT)
	if zoomIn:
		zoomVector = Vector2.ONE / zoomVector
	
	var oldPos = get_global_mouse_position()
		
	zoom *= zoomVector
	zoom = clamp(zoom,Vector2(MIN_ZOOM,MIN_ZOOM),Vector2(MAX_ZOOM,MAX_ZOOM))
	
	var newPos = get_global_mouse_position()
	var deltaPos = newPos-oldPos
	position -= deltaPos
