extends CharacterBody2D

class_name  PlayerCopy
@onready var animation = $AnimatedSprite2D
@export var player_ref : Player


@onready var anim_sprite : AnimatedSprite2D = $AnimatedSprite2D

var  _invincible = false

func _ready():
	if player_ref.playerId == 1:
		anim_sprite.play("default", 1, true)
	else:
		anim_sprite.play("default_angel", 1, true)


func _process(delta):
	rotation = player_ref.rotation
	global_position = player_ref.global_position
	scale = player_ref.scale

