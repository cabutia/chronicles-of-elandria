extends Node

var char_map: Dictionary = {
	"human": preload("res://Entities/Characters/Human.tscn"),
	"sample_npc": preload("res://Entities/NPC/SampleNPC.tscn")
}

func get_entity(name: String) -> PackedScene:
	print("Getting entity ", name)
	return char_map[name];
