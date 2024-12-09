class_name InventorySlot extends Control

@onready var item_texture: TextureRect = $CenterContainer/ItemTexture;
@onready var name_label: Label = $ItemName;
@onready var amount_label: Label = $ItemAmount;

var inventory_item: InventoryItemResource;

func set_inventory_item(_inventory_item: InventoryItemResource):
	inventory_item = _inventory_item
	name_label.text = inventory_item.item.name;
	amount_label.text = str("x", inventory_item.amount);
	item_texture.texture = inventory_item.item.inventory_texture;

func update_amount(amount: int):
	inventory_item.amount = amount;
	amount_label.text = str("x", amount)

func _ready():
	name_label.text = ''
	amount_label. text = '';
