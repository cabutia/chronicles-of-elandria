class_name MainCamera extends Camera2D

var player: Node2D
var player_node: Player;


func set_player(_player: Node2D):
	player = _player


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		position = player.position;
