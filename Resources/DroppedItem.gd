class_name DroppedItem extends Resource

@export var amount: int = 0;
@export var item: Item;

static func from_list_item(drop_list_item: DropListItem) -> DroppedItem:
	var amount = randi_range(drop_list_item.min_amount, drop_list_item.max_amount);
	var instance = DroppedItem.new()
	instance.item = drop_list_item.item;
	instance.amount = amount
	return instance
