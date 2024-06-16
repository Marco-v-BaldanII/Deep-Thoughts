extends CharacterBody2D

class_name  Player
@onready var shieldsprite = $escudoplayer

@onready var animation = $AnimatedSprite2D
@onready var gpu_particles = $GPUParticles2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D

@onready var particle_system : Node2D = $ParticleSystem

@export var rival_player : Player

var  frenesi_state : bool = false
@onready var frenesi_timer : Timer =  $frenesi_timer
signal checkpoint_signal
signal die

@export var rotate_speed = 4
@export var boost_speed = 9000

@export var stunn_time : float = 1

@export var bounce_coefficient : float = 3
@export var stunn_rotation_speed : float = 8 

var current_velocity :Vector2
@export var max_veloxity : int = 160
@export var super_velocity : int = 320

@export var playerId : int # to differentiate p1 and p2

@onready var InkSprite : Sprite2D = $Ink
@onready var ink_timer : Timer = $ink_timer

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var buffer_velocity : Vector2
var buffer_rotation : float

var _num_collisions : int = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var canMove : bool = true;

var boost_input := "string"
var turn_left_input := "string"
var turn_right_input := "string"
var super_boost_input := "string"

var saved_position : Vector2 = Vector2.ZERO

@onready var iframes_timer : Timer = $iframes_timer
@onready var small_iframes_timer = $small_iframes
@onready var big_timer : Timer = $big_timer
@onready var super_bar : TextureProgressBar = $ProgressBar/TextureProgressBar

@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

var  _invincible = false

func _ready():
	if playerId == 1:
		anim_sprite.play("default", 1, true)
	else:
		anim_sprite.play("default_angel", 1, true)

	if playerId== 1:
		boost_input = "boost"
		turn_left_input = "turn_left"
		turn_right_input = "turn_right"
		super_boost_input = "super_boost"
	else:
		boost_input = "boostp2"
		turn_left_input = "turn_leftp2"
		turn_right_input = "turn_rightp2"
		super_boost_input = "super_boostp2"

func _physics_process(delta):
	
	_handle_rotation(delta)
	
	_handle_movement_input(delta)
	
	super_boost(delta)

	_handle_collision(delta)
	
	move_and_collide(velocity * delta)
	

const SUPER_BAR_INCREASE = 40

func init(spawn_position :Vector2 ,Id : int ):
	global_position = spawn_position
	playerId = Id 
	


func _process(delta):
	if not super_bar == null:
		super_bar.value += SUPER_BAR_INCREASE *delta
	#print(super_bar.value)
	#if Input.is_action_just_pressed("shield"):
		#collision_shield()
	InkSprite.global_rotation  = 0


func _on_area_2d_body_entered(body):
	#print("entered")
	canMove = false;
	
func _handle_rotation(delta: float):
	
	
	var rotation_input =  Input.get_action_strength(turn_right_input) - Input.get_action_strength(turn_left_input) 
	
	if rotation_input == 0:
		buffer_rotation = move_toward(buffer_rotation , 0, 12 * delta)
	else:
		buffer_rotation = move_toward(buffer_rotation  , 4 * rotation_input, 1800 * delta)

	rotate(deg_to_rad(buffer_rotation))

func _handle_movement_input(delta : float):
	var input : float = Input.get_action_raw_strength(boost_input)
	
	
	if(canMove):
		if(input == 0):
			buffer_velocity.x = move_toward(buffer_velocity.x, 0, 2)
			buffer_velocity.y = move_toward(buffer_velocity.y, 0, 2)
		else:
			buffer_velocity.x = move_toward(buffer_velocity.x, max_veloxity, 60)
			buffer_velocity.y = move_toward(buffer_velocity.y, max_veloxity, 60)
			

		var dir : Vector2 = Vector2(0,1)
		dir = transform.basis_xform(dir)
		
		if frenesi_state:
			particle_system.show()
			velocity = Vector2(randf_range(3000,5000),randf_range(3000,5000))
			buffer_velocity = velocity
		else:
			if not particle_system == null:
				particle_system.hide()
	

		velocity = buffer_velocity * dir
		
const SUPER_BAR_DECELERATION = 180


func super_boost(delta: float):
	
		if canMove:
			var input : float = Input.get_action_raw_strength(super_boost_input)
			if Input.is_action_pressed(super_boost_input):
				gpu_particles.show()
				if super_bar.value > 5:
					super_bar.value -= SUPER_BAR_DECELERATION *delta
					var dir : Vector2 = Vector2(0,1)
					dir = transform.basis_xform(dir)
					buffer_velocity.x = move_toward(buffer_velocity.x, super_velocity, 60)
					buffer_velocity.y = move_toward(buffer_velocity.y, super_velocity, 60)
				
					velocity = buffer_velocity * dir
				else:
					
					super_bar.value = 0
			else:
				gpu_particles.hide()
	
func _handle_collision(delta :float):
	var collision := move_and_collide(velocity* delta)
	
	if collision :
		var collider := collision.get_collider()
		if playerId == 1:
			anim_sprite.play("stun_demon", 1, true)
		else:
			anim_sprite.play("stun_angel", 1, true)
		
		if collider.is_in_group("clock"):
			return
		elif collider.is_in_group("pinball"):
			velocity *= -bounce_coefficient * Vector2(0,-5)

	if not _invincible:
		if collision:
			_num_collisions += 1
			small_iframes_timer.start(0.2)
		
				
			velocity.x = clampf( velocity.x,60.0, max_veloxity)
			velocity.y = clampf( velocity.y,60.0, max_veloxity)
			velocity *= -bounce_coefficient * _num_collisions
			move_and_slide()
			iframes_timer.start(0.5)
			#start iframes timer
			if _num_collisions >= 3:
				_invincible = true
				_num_collisions = 0
				small_iframes_timer.stop()
			canMove = false
			
		
	if not canMove and not _invincible:
		velocity.x = move_toward(velocity.x, 0, 20)
		velocity.y = move_toward(velocity.y, 0, 20)
		rotate(deg_to_rad(stunn_rotation_speed))
		if velocity.length() < 0.4:
			canMove = true
			velocity = Vector2.ZERO
			buffer_velocity = Vector2.ZERO
	else:
		_num_collisions = 0



func _on_iframes_timer_timeout():
	shieldsprite.hide()
	_invincible = false
	canMove = true
	if playerId == 1:
		anim_sprite.play("default", 1, true)
	else:
		anim_sprite.play("default_angel", 1, true)
	pass # Replace with function body.
func _on_small_iframes_timeout():
	_invincible = false
	small_iframes_timer.stop()
	velocity = Vector2.ZERO
	buffer_velocity = Vector2.ZERO
	if playerId == 1:
		anim_sprite.play("default", 1, true)
	else:
		anim_sprite.play("default_angel", 1, true)

	canMove = true
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.is_in_group("checkpoint"):
		saved_position = global_position
		checkpoint_signal.emit()
		
	elif area.is_in_group("death") and not _invincible:
		CheckPointManager.dead_player = self
		CheckPointManager.dead_id = playerId
		CheckPointManager._on_player_die()
	elif area.is_in_group("ink"):
		InkSprite.show()
		ink_timer.start(5)
		
	elif area.is_in_group("item"):
		collision_shield()
		
	elif area.is_in_group("Frenesi"):
		rival_player.frenesi()
	
	elif area.is_in_group("biiig"):
		rival_player.grow_big()

func collision_shield():
	_invincible = true
	iframes_timer.start(7)
	shieldsprite.show()



func _on_ink_timer_timeout():
	
	InkSprite.hide()
	ink_timer.stop()
	
	
func frenesi():
	frenesi_state = true
	frenesi_timer.start((2))
	velocity = Vector2(randf_range(-5000,5000),randf_range(-5000,5000))
	buffer_velocity = velocity
	


func _on_frenesi_timer_timeout():
	frenesi_state = false
	frenesi_timer.stop()
	pass # Replace with function body.

func grow_big():
	scale = Vector2(2,2)
	big_timer.start(5)


func _on_big_timer_timeout():
	big_timer.stop()
	scale = Vector2(2,2)
	pass # Replace with function body.
	
	
func _on_aria_2d_area_entered(area):
	get_tree().change_scene_to_file("res://Pau/gudendin.tscn")
	pass # Replace with function body.

func _on_areeeeaaaa_area_entered(area):
	get_tree().change_scene_to_file("res://Pau/badendin.tscn")
	pass # Replace with function body.
