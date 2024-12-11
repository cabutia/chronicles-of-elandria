# Inventory manager
extends Node

@onready var game_manager = $"/root/GameManager"

# DEV
var object_map: Dictionary = {
	"gold_coin": preload("res://Resources/Items/GoldCoin.tres"),
	"super_rare_gold_coin": preload("res://Resources/Items/SuperRareGoldCoin.tres")
}
# DEV

var InventorySlotScn = preload("res://UI/GameUI/InventorySlot.tscn");

var inventory_items: Array[InventoryItemResource] = []
var inventory_node: Control;
var max_inventory_size = 10;
var slots: Array[InventorySlot] = []

func set_node(node: Control):
	inventory_node = node;

func initialize():
	if inventory_node:
		for i in max_inventory_size:
			var slot = InventorySlotScn.instantiate();
			inventory_node.get_grid_container().add_child(slot)
			slots.append(slot)
		
		update_inventory()
	
func get_slot_at(index: int) -> InventorySlot:
	if index > len(slots):
		return
	return slots[index]
	
func map_item_to_resource(name: String) -> Item:
	if object_map.has(name):
		return object_map[name];
	return
	
func create_inventory_item(index: int, item: Item, amount: int) -> InventoryItemResource:
	var resource = InventoryItemResource.new();
	resource.slot = index;
	resource.item = item
	resource.amount = amount;
	return resource
	
func load(items: Array[Dictionary]):
	for item in items:
		var resource = create_inventory_item(item.slot, map_item_to_resource(item.id), item.amount)
		inventory_items.append(resource);
	update_inventory()
	
func update_inventory():
	if !inventory_node:
		return;
	for inventory_item in inventory_items:
		var slot = get_slot_at(inventory_item.slot)
		if slot:
			slot.set_inventory_item(inventory_item)
			
func find_existing_item_by_name(name: String) -> InventoryItemResource:
	for inventory_item in inventory_items:
		if inventory_item.item.name == name:
			return inventory_item;
	return
	
func can_pickup(dropped_item: DroppedItemResource) -> bool:
	var inventory_item = find_existing_item_by_name(dropped_item.item.name);
	if inventory_item and inventory_item.item.stackable:
		return true
	return len(inventory_items) < max_inventory_size

func on_pickup_item(dropped_item: DroppedItemResource):
	if !can_pickup(dropped_item):
		return
	game_manager.send_message(str("Picked up x", dropped_item.amount, " ", dropped_item.item.name))
	# Find existing item in inventory
	var inventory_item = find_existing_item_by_name(dropped_item.item.name);
	
	print("Inventory item ", inventory_item)
	# If found, and is stackable, update the amount
	if inventory_item and inventory_item.item.stackable:
		print("Inventory item found with amount: ", inventory_item.amount)
		inventory_item.amount += dropped_item.amount
		print("New inventory item amount: ", inventory_item.amount)
		var slot = get_slot_at(inventory_item.slot);
		if slot:
			print("Slot found at ", inventory_item.slot)
			slot.update_amount(inventory_item.amount);
		else:
			print("Slot not found ")
			return
	elif len(inventory_items) < max_inventory_size:
		var first_empty_slot: InventorySlot;
		var empty_slot_idx;
		var slot_idx = 0
		for slot in slots:
			if slot.is_empty():
				first_empty_slot = slot
				empty_slot_idx = slot_idx
				print("First slot empty is at ", slot_idx)
				break
			slot_idx += 1
		if !first_empty_slot:
			print("No slots available")
			return
		var item_resource = map_item_to_resource(dropped_item.item.id)
		var new_inventory_item = create_inventory_item(empty_slot_idx, item_resource, dropped_item.amount)
		first_empty_slot.set_inventory_item(new_inventory_item)
		slots[slot_idx] = first_empty_slot
		inventory_items.append(new_inventory_item)
		update_inventory()
		
		
	# Else check if inventory has space left
		# If there's space left, create new item
		# Else do nothing
