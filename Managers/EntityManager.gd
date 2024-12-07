extends Node

var DroppedItemScn = preload("res://Objects/DroppedItem.tscn");

func on_entity_killed(entity: Node2D):
	if entity.drop:
		print("Should drop!", entity.drop.list)
		var i = 0;
		for drop_list_item in entity.drop.list:
			var drop_chance = randi_range(0, 100)
			var gonna_drop = drop_chance <= drop_list_item.chance
			if !gonna_drop:
				continue
			var amount = randi_range(drop_list_item.min_amount, drop_list_item.max_amount);
			var item = DroppedItemScn.instantiate();
			var dropped_item = DroppedItem.new()
			dropped_item.item = drop_list_item.item;
			dropped_item.amount = amount
			print("--- Setup dropped_item ", dropped_item.item.name, " ", dropped_item.amount)
			item.set_item(dropped_item)
			var item_position = entity.global_position;
			item_position.y = item_position.y + (i * 100)
			item.global_position = item_position
			get_tree().get_root().add_child(item)
			i += 1
