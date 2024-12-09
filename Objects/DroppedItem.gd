extends Node2D

@onready var label: Label = $Label;
@onready var sprite_container: Node2D = $SpriteContainer
@onready var pickup_area: Area2D = $PickupArea;

var item: DroppedItem;

signal pickup;

# Called when the node enters the scene tree for the first time.
func _ready():
	if item:
		label.text = str("x", item.amount, " ", item.item.name)
	pickup_area.connect("body_entered", on_body_entered)
	
func on_body_entered(entity: Node2D):
	if entity.is_in_group("player"):
		pickup.emit(item)
		queue_free()
	
func set_item(_item: DroppedItem):
	item = _item
	set_sprite(item.item.dropped_sprite)
	
func set_sprite(dropped_sprite: PackedScene):
	var dropped_item = dropped_sprite.instantiate()
	dropped_item.position = position
	add_child(dropped_item)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
