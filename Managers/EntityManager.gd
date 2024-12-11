extends Node

@onready var game_manager = $"/root/GameManager"
var DroppedItemScn = preload("res://Objects/DroppedItem.tscn");

func should_drop(item: DropListItem) -> bool:
	var drop_chance = randi_range(0, 100)
	return drop_chance <= item.chance
	
func handle_entity_drop(entity: BaseNPC):
	var player = game_manager.get_player()
	if entity.drop:
		print("Should drop!", entity.drop.list)
		var i = 0;
		for drop_list_item in entity.drop.list:
			if !should_drop(drop_list_item):
				return
			var item = DroppedItemScn.instantiate();
			var dropped_item = DroppedItemResource.from_list_item(drop_list_item)
			item.set_item(dropped_item)
			var item_position = entity.global_position;
			item_position.y = item_position.y + (i * 100)
			item.global_position = item_position
			get_tree().get_root().add_child(item)
			i += 1
			item.connect("pickup", player.on_pickup)

func on_entity_killed(entity: BaseNPC):
	handle_entity_drop(entity)
