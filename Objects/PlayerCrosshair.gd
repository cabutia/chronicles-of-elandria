extends Node2D

@onready var spawn_point = $SpawnPoint;

var display_timer: Timer;

func display():
	visible = true
	display_timer.start()

func on_display_timer_timeout():
	visible = false;
	
func get_spawn_point() -> Vector2:
	return spawn_point.global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false;
	display_timer = Timer.new()
	display_timer.one_shot = true
	display_timer.wait_time = 1.5
	display_timer.connect('timeout', on_display_timer_timeout)
	add_child(display_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
