extends Node2D

@onready var world_manager = $"/root/WorldManager";
@onready var save_manager = $"/root/SaveManager";
@onready var entity_map = $"/root/EntityMap";

@onready var player_scene: PackedScene = preload("res://Entities/Player.tscn");

@onready var main_camera: MainCamera = $MainCamera;
@onready var player_placeholder: Node2D = $PlayerPlaceholder;
@onready var state = save_manager.load_game();

var is_lumia: bool = false;


func initialize_world():
	world_manager.load_map(state.world);

func initialize_camera():
	main_camera.set_player(player_placeholder)

func initialize_player():
	var player = player_scene.instantiate() as Player;
	player_placeholder.add_child(player)
	player.position = Vector2(100, 0)
	player.set_character(state.player.type);

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_world()
	initialize_player()	
	initialize_camera()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if (is_lumia):
			world_manager.change('vyrka')
			is_lumia = false
		else:
			world_manager.change('lumia')
			is_lumia = true
		
