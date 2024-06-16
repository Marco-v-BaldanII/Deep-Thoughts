extends Node
class_name Game_Manager

@export var player_pref : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	CheckPointManager.player_pref = player_pref
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
