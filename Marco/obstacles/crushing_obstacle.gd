extends Node2D
class_name CrushingObstacle

@onready var _left_object :PathFollow2D = $left_wall/Path2D/PathFollow2D
@onready var _right_object :PathFollow2D = $right_wall/Path2D/PathFollow2D

@export var speed : float = 0.1
var og_speed : float = speed
@export var acceleration : float = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	_left_object.progress_ratio += speed *delta
	_right_object.progress_ratio += speed * delta
	
	pass
func _physics_process(delta):
	
	speed += acceleration * delta
	


func _on_area_2d_area_entered(area):
	
	if area.is_in_group("death"):
		speed = og_speed
	
	pass # Replace with function body.
