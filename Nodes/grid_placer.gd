class_name grid_placer
extends Node2D

const LINE_THICKNESS = 10.0
const GRID_DISTANCE = 100.0

func _process(delta):
	queue_redraw()

func drawGrid():
	var topY = make_canvas_position_local(Vector2(0,0)).y
	var bottomY = make_canvas_position_local(get_viewport_rect().size).y
	var leftX = make_canvas_position_local(Vector2(0,0)).x
	var rightX = make_canvas_position_local(get_viewport_rect().size).x
	
	var vertXStart = leftX-fmod(leftX,GRID_DISTANCE)
	var horYStart = topY-fmod(topY,GRID_DISTANCE)
	
	var horizontalLines = 0
	var horLinePos = vertXStart + GRID_DISTANCE*horizontalLines
	while(horLinePos < rightX):
		horLinePos = vertXStart + GRID_DISTANCE*horizontalLines
		draw_line(Vector2(horLinePos, topY), Vector2(horLinePos, bottomY), Color.BLACK, LINE_THICKNESS)
		horizontalLines += 1
	var verticalLines = 0
	var virtLinePos = horYStart + GRID_DISTANCE * verticalLines
	while(virtLinePos < bottomY):
		virtLinePos = horYStart + GRID_DISTANCE * verticalLines
		draw_line(Vector2(leftX, virtLinePos), Vector2(rightX, virtLinePos), Color.BLACK, LINE_THICKNESS)
		verticalLines += 1
	
func _draw():
	drawGrid()
