extends Node2D

@onready var check_points :Array  = get_tree().get_nodes_in_group("checkpoint")

static var dead_player : Player
static var dead_id : int

static var player_pref : PackedScene

signal respawn_player

var new_player :Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_checkpoint_signal():
	pass # Replace with function body.



func _on_player_die():
	respawn_player.emit()
	if is_instance_valid(dead_player):
		var id : int = dead_player.playerId
		var pos : Vector2 = dead_player.saved_position
		print(dead_player.saved_position)
		
		dead_player.init( pos, id )

		
	
	

	
