extends Node2D

func _process(delta):
	queue_redraw()

func drawGrid():
	var topY = make_canvas_position_local(Vector2(0,0)).y
	var bottomY = make_canvas_position_local(get_viewport_rect().size).y
	var leftX = make_canvas_position_local(Vector2(0,0)).x
	var rightX = make_canvas_position_local(get_viewport_rect().size).x
	
	var vertXStart = leftX-fmod(leftX,100)
	
	for i in range(10):
		draw_line(Vector2(vertXStart + 100*i, topY), Vector2(vertXStart + 100*i, bottomY), Color.BLACK, 10/get_viewport().get_camera_2d().zoom.x)
	for i in range(10):
		draw_line(Vector2(rightX, 100*i), Vector2(leftX, 100*i), Color.BLACK, 10/get_viewport().get_camera_2d().zoom.x)
	
func _draw():
	drawGrid()
