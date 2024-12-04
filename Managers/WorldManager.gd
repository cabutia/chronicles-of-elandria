# WorldManager
extends Node

var VirkaWorld: PackedScene = preload("res://Worlds/Vyrka.tscn");
var LumiaWorld: PackedScene = preload("res://Worlds/Lumia.tscn");

var worlds: Dictionary = {
	"lumia": {
		"name": "Lumia",
		"scene": LumiaWorld,
		"spawn_point": Vector2(100, 100)
	},
	"vyrka": {
		"name": "Vyrka",
		"scene": VirkaWorld,
		"spawn_point": Vector2(100, 0)
	}
}

var current_world: Node;

signal change_started
signal change_finished
signal change_ready;

@onready var target = get_tree().get_root().get_node("Game/WorldContainer")
@onready var fader: CanvasModulate = get_tree().get_root().get_node("Game/WorldFader")

var traveling = false;
var target_world: String;

func get_fader_player() -> AnimationPlayer:
	return fader.get_node("AnimationPlayer")

func change(name: String):
	target_world = name
	traveling = true
	change_started.emit();
	var animation_player = get_fader_player()
	if animation_player:
		animation_player.connect('animation_finished', on_fade_finish)
		animation_player.play('fade_in')
	
func on_fade_finish(name: String):
	var animation_player = get_fader_player()
	if name == "fade_in":
		load_map(target_world)
		if animation_player:
			animation_player.play('fade_out')
		change_ready.emit(get_world(target_world).spawn_point)
	elif name == 'fade_out':
		change_finished.emit()
		target_world = ''
		traveling = false
		

func is_traveling():
	return traveling
	
func world_exist(name: String) -> bool:
	return worlds.has(name)
	
func get_world(name: String) -> Dictionary:
	return worlds[name];

# Called when the node enters the scene tree for the first time.
func load_map(name: String):
	if !world_exist(name):
		return
	var world = get_world(name)
	var children = target.get_children();
	for child in children:
		child.queue_free()
	var instance = world.scene.instantiate();
	current_world = instance;
	target.add_child(current_world)
	
func get_current_world():
	return current_world;

func get_target_world():
	return target_world;
	
func get_target_world_name():
	return get_world(get_target_world()).name
