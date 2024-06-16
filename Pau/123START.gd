extends Node2D

var eTime: float = 0

func _ready():
	$Timer.start()

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://Marco/maindefinitive.tscn")
