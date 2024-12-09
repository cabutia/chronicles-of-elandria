class_name Enemy extends BaseNPC


var EnemyStats = preload("res://Entities/NPC/EnemyStats.tres");
var EnemyDrop = preload("res://Resources/SampleEnemyDrop.tres");

@export var speed = 100;

var stats: EntityStats = EnemyStats.duplicate()
var drop: EntityDrop = EnemyDrop.duplicate()
var direction: Vector2;

func _ready():
	direction = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
	play('walk')
	
	stats.create_healthbar(self)
	
func _physics_process(delta):
	position += direction * (speed / 100)

func take_damage(attack_amount: int) -> bool:
	if !alive:
		return false
	stats.sub_health(attack_amount)
	if stats.health == 0:
		entity_die()
		return true
	return false
