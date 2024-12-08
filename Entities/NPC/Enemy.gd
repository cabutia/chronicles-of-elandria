class_name Enemy extends CharacterBody2D


var EnemyStats = preload("res://Entities/NPC/EnemyStats.tres");
var EnemyDrop = preload("res://Resources/SampleEnemyDrop.tres");

@onready var entity_manager: EntityManager = $"/root/EntityManager"
@onready var animation_player: AnimationPlayer = $AnimationPlayer;

@export var speed = 100;

signal die;

var stats: EntityStats = EnemyStats.duplicate()
var drop: EntityDrop = EnemyDrop.duplicate()
var direction: Vector2;
var alive: bool = true;

func _ready():
	direction = Vector2(randi_range(-1, 1), randi_range(-1, 1)).normalized()
	if animation_player.has_animation('walk'):
		animation_player.play('walk')
	
	stats.create_healthbar(self)
	
func _physics_process(delta):
	position += direction * (speed / 100)

func take_damage(attack_amount: int) -> bool:
	if !alive:
		return false
	stats.sub_health(attack_amount)
	if stats.health == 0:
		alive = false
		die.emit(self)
		entity_manager.on_entity_killed(self)
		queue_free()
		return true
	return false
