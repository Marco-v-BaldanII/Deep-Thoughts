extends Node2D
class_name Obstacle

@export var speed : float = 0.2
@onready var sprite : Sprite2D = $Path2D/PathFollow2D/Sprite2D
@onready var _path_object :PathFollow2D = $Path2D/PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	_path_object.loop = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.rotate(deg_to_rad(2))
	
	if(_path_object.progress_ratio > 0.97 and speed > 0):
		_path_object.progress_ratio = 0.96
		speed *= -1
	elif(_path_object.progress_ratio < 0.3 and speed < 0):
		_path_object.progress_ratio = 0.4
		speed *= -1

	_path_object.progress_ratio += speed * delta
	
	pass
