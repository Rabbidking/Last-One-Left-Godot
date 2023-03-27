extends Area2D

# exported variables
@export var is_open = false

# nodes
var doorOpen: Sprite2D
var doorClosed: Sprite2D
var ExitDoor: Node2D

func _ready():
	# get sprite nodes
	doorOpen = $ExitDoor/doorOpen
	doorClosed = $ExitDoor/doorClosed
	ExitDoor = $ExitDoor

	# set initial state and appearance
	is_open = false
	doorOpen.visible = false
	doorClosed.visible = true

func exit_level():
	# set open state and appearance
	is_open = true
	doorOpen.visible = true
	doorClosed.visible = false

func reset():
	# set closed state and appearance
	is_open = false
	doorOpen.visible = false
	doorClosed.visible = true
