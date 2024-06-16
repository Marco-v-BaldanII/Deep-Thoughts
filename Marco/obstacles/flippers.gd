extends Node2D
class_name Flipper
var buffer_rotation : float = 0

@export var rotate_speed : float  = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):

	#buffer_rotation = move_toward(buffer_rotation , 0, 12 * delta)	
	buffer_rotation = move_toward(buffer_rotation  , rotate_speed , 1800 * delta)
	rotate(deg_to_rad(buffer_rotation))

	
func invert_speed():
	rotate_speed*= -1
