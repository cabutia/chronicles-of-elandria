extends Area2D

@onready var die_timer: Timer = $DieTimer;

@export var spread = 0;
@export var speed = 30;

var target: Vector2;
var direction: Vector2;

func _ready():
	die_timer.connect('timeout', on_die)
	connect('body_entered', on_hit)
	
func _physics_process(delta):
	position += direction.normalized() * speed
	
func on_hit(body: Node2D):
	on_die()
	
func on_die():
	queue_free()

func set_target(point: Vector2):
	target = point
	var target_direction = global_position.direction_to(target)
	var angle = target_direction.angle()
	var spread_angle = deg_to_rad(spread)
	var new_angle = angle + randf_range(-spread_angle, spread_angle)
	direction = Vector2(cos(new_angle), sin(new_angle))
	look_at(direction)
