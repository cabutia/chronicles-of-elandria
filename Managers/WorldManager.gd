extends Node

var VirkaWorld: PackedScene = preload("res://Worlds/Vyrka.tscn");
var LumiaWorld: PackedScene = preload("res://Worlds/Lumia.tscn");
var world_map: Dictionary = {
	"vyrka": VirkaWorld,
	"lumia": LumiaWorld
}

var current_world: Node;
@onready var target = get_tree().get_root().get_node("Game/WorldPlaceholder")

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
