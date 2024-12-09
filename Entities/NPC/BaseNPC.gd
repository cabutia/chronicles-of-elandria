class_name BaseNPC extends BaseCharacter

@onready var entity_manager = $"/root/EntityManager";

var alive: bool = true;
signal die;

func entity_die():
	alive = false
	die.emit(self)
	entity_manager.on_entity_killed(self)
	if animation_player.has_animation('die'):
		animation_player.play('die')
		animation_player.connect('animation_finished', on_animation_finished)
	else:
		queue_free()

func on_animation_finished(name: String):
	if name == 'die':
		queue_free()

