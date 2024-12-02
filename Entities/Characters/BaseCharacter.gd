class_name BaseCharacter extends Node2D

@onready var sprite = $Sprite;
@onready var animation_player = $AnimationPlayer;

func get_sprite() -> Sprite2D:
	return sprite;
	
func get_animation_player() -> AnimationPlayer:
	return animation_player;
	
func play(name: String):
	if animation_player and animation_player.has_animation(name):
		animation_player.play(name)
