# Game manager
extends Node2D

@onready var world_manager = $"/root/WorldManager";
@onready var inventory_manager = $"/root/InventoryManager";
@onready var save_manager = $"/root/SaveManager";
@onready var entity_map = $"/root/EntityMap";

@onready var player_scene: PackedScene = preload("res://Entities/Player.tscn");

@onready var state = save_manager.load_game();

var main_camera: MainCamera;
var player: Player;
var is_lumia: bool = false;

signal on_send_message;

func set_main_camera(_main_camera):
	main_camera = _main_camera
	
func get_camera() -> MainCamera:
	return main_camera

func initialize_world():
	world_manager.load_map(state.world);

func initialize_camera():
	main_camera.set_player(player)
	world_manager.connect('change_ready', update_camera_bounds)
		
func update_camera_bounds(_name):
	var world = world_manager.get_current_world();
	# var tilemap = world.find_node("World/TileMap")
	# print("tilemap", tilemap)

func initialize_player():
	player = player_scene.instantiate() as Player;
	player.set_type(state.player.type)
	player.position = Vector2(100, 0)
	player.y_sort_enabled = true
	get_tree().get_root().get_node("Game/PlayerPlaceholder").add_child(player)
	
func initialize_inventory():
	var items: Array[Dictionary] = [
#		{
#			"slot": 0,
#			"id": "gold_coin",
#			"amount": 423
#		}
	];
	inventory_manager.initialize()
	inventory_manager.load(items)

func get_player():
	return player;
	
# Called when the node enters the scene tree for the first time.
func initialize():
	initialize_world()
	initialize_player()	
	initialize_inventory()
	initialize_camera()
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and !world_manager.is_traveling():
		if (is_lumia):
			world_manager.change('vyrka')
			is_lumia = false
		else:
			world_manager.change('lumia')
			is_lumia = true		

func send_message(message: String):
	on_send_message.emit(message)
