extends Node2D

@export var Entity: PackedScene;
@export var range = 1000
@export var spawn_interval = 2
@export var max_entities = 3

@onready var collision_area = $SpawnArea;
@onready var timer = $SpawnTimer;

var entities: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	collision_area.shape.radius = range;
	timer.wait_time = spawn_interval
	timer.connect('timeout', spawn)
	
func spawn():
	if len(entities) == max_entities:
		return
	# Prepare instance
	var instance = Entity.instantiate();
	instance.global_position = global_position
	instance.connect('die', on_entity_exited)
	
	# Add to scene
	entities.append(instance.get_instance_id())
	get_tree().get_root().add_child(instance)

# Remove entity from array when die
func on_entity_exited(entity):
	var id = entity.get_instance_id();
	var idx = entities.find(id)
	if idx == -1:
		return
	entities.remove_at(idx)

func _process(delta):
	pass
