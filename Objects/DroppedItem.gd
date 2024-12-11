class_name DroppedItem extends Node2D

@onready var label: Label = $Label;
@onready var sprite_container: Node2D = $SpriteContainer
@onready var pickup_area: Area2D = $PickupArea;
@onready var despawn_timer: Timer = $DespawnTimer;

var item: DroppedItemResource;

signal pickup;

# Called when the node enters the scene tree for the first time.
func _ready():
	if item:
		label.text = str("x", item.amount, " ", item.item.name)
		start_despawn_timer(item.item.drop_duration);
		despawn_timer.connect("timeout", on_despawn_timer_timeout)
	pickup_area.connect("body_entered", on_body_entered)
	
func on_despawn_timer_timeout():
	queue_free()
	
func on_body_entered(entity: Node2D):
	if entity.is_in_group("player"):
		pickup.emit(self)
		
func start_despawn_timer(time: int):
	if time == 0:
		return
	despawn_timer.wait_time = time
	despawn_timer.start()
	
func set_item(_item: DroppedItemResource):
	item = _item
	set_sprite(item.item.dropped_sprite)
	
func set_sprite(dropped_sprite: PackedScene):
	var dropped_item = dropped_sprite.instantiate()
	dropped_item.position = position
	add_child(dropped_item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
