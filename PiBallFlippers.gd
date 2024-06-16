extends Node2D
class_name PinballFlipper

@onready var dir_timer : Timer = $direction_timer

var buffer_rotation : float = 0

@export var time : float = 1

@export var rotate_speed : float  = 2

var up : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	dir_timer.start(time)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	
	if up:
		buffer_rotation = move_toward(buffer_rotation, rotate_speed, 5 * delta )
		if buffer_rotation == rotate_speed : 
			up = false
	else:
		buffer_rotation = move_toward(buffer_rotation, -rotate_speed, 5 * delta)
		if buffer_rotation == -rotate_speed : 
			up = true
		
	rotate(deg_to_rad(buffer_rotation))
		#if rotation_input == 0:
		#buffer_rotation = move_toward(buffer_rotation , 0, 12 * delta)
	#else:
		#buffer_rotation = move_toward(buffer_rotation  , rotate_speed * rotation_input, 1800 * delta)



