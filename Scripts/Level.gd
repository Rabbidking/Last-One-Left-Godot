extends Node2D

var clones = []  # list to hold all the clones
var num_alive = 1
@export var num_clones = 5 #  number of clones to spawn


@onready var exit_door = $ExitDoor

func _ready():
	spawn_clones()
	
func spawn_clones():
	var offset = 90  # horizontal offset between clones
	var start_pos = position  # starting position of first clone
	var x_offset = -((num_clones-1)*offset/2) # calculate offset from center
	for i in range(num_clones):
		var clone = preload("res://Scenes/Clone.tscn").instantiate()
		add_child(clone)
		clone.position = start_pos + Vector2(i * offset, 0)
		clones.append(clone)
		num_alive += 1
		
func _process(delta):
	#print(num_clones_alive)
	if num_alive == 1:
		exit_door.exit_level()
	print(num_alive)
	


func end_level():
	# code to end the level goes here
	#get_tree().change_scene_to_file("res://Scenes/Levels/Level2.tscn")
	pass


func _on_player_decrease_living():
	num_alive -= 1

func on_clone_decrease_living():
	num_alive -= 1
