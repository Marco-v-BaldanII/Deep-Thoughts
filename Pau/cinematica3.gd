extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	pass # Replace with function body.


func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Pau/123START.tscn")
	pass # Replace with function body.
