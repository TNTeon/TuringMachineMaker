@abstract
class_name TuringMachine

var name : String = ""

var font : FontFile

func setName(_name : String):
	name = _name

func setFont(_font : FontFile):
	font = _font

func setMachine(_name : String, _font : FontFile):
	setName(_name)
	setFont(_font)

@abstract
func saveMachine()

@abstract
func singleStep(readingValue)

@abstract
func reset()
