class_name Tape
extends Control

@onready var tile_container = $TileContainer

const TILE = preload("uid://cidi5wj64sjnn")


var lowIndex : int = 1
var highIndex : int = 0

var currentIndex = 0

var tweening : bool = false

var speed = 1.0

func _ready():
	lowIndex = 1
	highIndex = 0
	currentIndex = 0
	tile_container.size = Vector2(810,73)
	addIndexLeft()
	pointToIndex0()
	
	addIndexLeft()
	addIndexRight()
	
	checkVisiblity()
	
	
func checkVisiblity():
	if abs(currentIndex - lowIndex) < 12:
		addIndexLeft()
		checkVisiblity()
	if abs(currentIndex - highIndex) < 12:
		addIndexRight()
		checkVisiblity()
	
func addIndexLeft():
	var newTile : Tile = TILE.instantiate()
	newTile.index = lowIndex - 1
	lowIndex -= 1
	
	tile_container.add_child(newTile)
	tile_container.move_child(newTile,0)
	
	tile_container.position.x -= 25

func addIndexRight():
	var newTile = TILE.instantiate()
	newTile.index = highIndex + 1
	highIndex += 1
	
	tile_container.add_child(newTile)
	
	tile_container.position.x += 25

func pointToIndex0():
	tile_container.position.x = 0 * -50 + 170

func moveRight():
	move(1)

func moveLeft():
	move(-1)

func move(dir):
	if !tweening:
		tweening = true
		currentIndex += dir
		var tween = get_tree().create_tween()
		tween.tween_property(tile_container,"position",Vector2(tile_container.position.x+(-dir*50),tile_container.position.y),0.1 / speed)
		tween.finished.connect(noLongerTweening)
		
	else:
		push_error("OVERLOADING MOVEMENT! Can't do so much so fast! We need to wait for the tween!")

func noLongerTweening():
	tweening = false
	checkVisiblity()

func setCurrentIndexValue(value):
	var tile : Tile = tile_container.get_child(-lowIndex + currentIndex)
	tile.setValue(value)

func getCurrentIndexValue():
	var tile : Tile = tile_container.get_child(-lowIndex + currentIndex)
	return tile.getValue()

func setSpeed(value):
	speed = value
	
func reset():
	for child in tile_container.get_children():
		child.free()
	_ready()
