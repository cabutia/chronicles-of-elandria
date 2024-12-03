# WorldManager
extends Node

var VirkaWorld: PackedScene = preload("res://Worlds/Vyrka.tscn");
var LumiaWorld: PackedScene = preload("res://Worlds/Lumia.tscn");
var world_map: Dictionary = {
	"vyrka": VirkaWorld,
	"lumia": LumiaWorld
}
var spawn_points: Dictionary = {
	"vyrka": Vector2(100, 100),
	"lumia": Vector2(100, 0)
}

var world_name_map: Dictionary = {
	"vyrka": "Vyrka",
	"lumia": "Lumia"
}

var current_world: Node;

signal change_started
signal change_finished
signal change_ready;

@onready var target = get_tree().get_root().get_node("Game/WorldContainer")
@onready var fader: CanvasModulate = get_tree().get_root().get_node("Game/WorldFader")
@onready var animation_player: AnimationPlayer = fader.get_node("AnimationPlayer")

var traveling = false;
var target_world: String;

func change(name: String):
	target_world = name
	traveling = true
	change_started.emit();
	animation_player.connect('animation_finished', on_fade_finish)
	animation_player.play('fade_in')
	
func on_fade_finish(name: String):
	if name == "fade_in":
		load_map(target_world)
		animation_player.play('fade_out')
		change_ready.emit(spawn_points[target_world])
	elif name == 'fade_out':
		change_finished.emit()
		target_world = ''
		traveling = false
		

func is_traveling():
	return traveling

# Called when the node enters the scene tree for the first time.
func load_map(name: String):
	var world = world_map[name];
	if !world:
		pass
	var children = target.get_children();
	for child in children:
		child.queue_free()
	var instance = world.instantiate();
	current_world = instance;
	target.add_child(current_world)
	
func get_current_world():
	return current_world;

func get_target_world():
	return target_world;
	
func get_target_world_name():
	return world_name_map[get_target_world()]
