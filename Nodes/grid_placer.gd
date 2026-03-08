extends Node2D

func _process(delta):
	queue_redraw()

func drawGrid():
	var topY = make_canvas_position_local(Vector2(0,0)).y
	var bottomY = make_canvas_position_local(get_viewport_rect().size).y
	var leftX = make_canvas_position_local(Vector2(0,0)).x
	var rightX = make_canvas_position_local(get_viewport_rect().size).x
	
	var vertXStart = leftX-fmod(leftX,100)
	var horYStart = topY-fmod(topY,100)
	
	var horizontalLines = 0
	while(vertXStart + 100*horizontalLines < rightX):
		draw_line(Vector2(vertXStart + 100*horizontalLines, topY), Vector2(vertXStart + 100*horizontalLines, bottomY), Color.BLACK, 10)
		horizontalLines += 1
	var verticalLines = 0
	while(horYStart + 100*verticalLines < bottomY):
		draw_line(Vector2(leftX, horYStart + 100*verticalLines), Vector2(rightX, horYStart + 100*verticalLines), Color.BLACK, 10)
		verticalLines += 1
	
func _draw():
	drawGrid()
