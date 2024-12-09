extends Control

@onready var inventory_manager = $"/root/InventoryManager";
@onready var grid_container = $Panel/MarginContainer/VFlowContainer/GridContainer;

func get_grid_container() -> GridContainer:
	return grid_container;

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_manager.set_node(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
