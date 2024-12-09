class_name Item extends Resource

@export var name: String = 'Undefined';
@export var weight: int = 0;
@export var stackable: bool = true;

@export var dropped_sprite: PackedScene;
@export var inventory_texture: Texture2D;
