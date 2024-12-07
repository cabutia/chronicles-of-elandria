extends Node2D

@onready var label: Label = $Label;

var item: DroppedItem;

# Called when the node enters the scene tree for the first time.
func _ready():
	if item:
		print("Ready with item", item)
		var _label = str("x", item.amount, " ", item.item.name)
		label.text = _label
	
func set_item(_item: DroppedItem):
	print("Setting item", _item)
	item = _item

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
