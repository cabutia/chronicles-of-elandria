class_name Item extends Resource

@export var id: String = 'undefined';
@export var name: String = 'Undefined';
@export var weight: int = 0;
@export var stackable: bool = true;
@export var drop_duration: int = 0;

@export var dropped_sprite: PackedScene;
@export var inventory_texture: Texture2D;
