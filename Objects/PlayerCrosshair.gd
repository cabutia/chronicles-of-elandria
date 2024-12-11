extends Node2D

@onready var spawn_point = $SpawnPoint;

var display_timer: Timer;
var target: Vector2 = Vector2.ZERO;
var _theta;

func display():
	visible = true
	display_timer.start()

func on_display_timer_timeout():
	visible = false;
	
func get_spawn_point() -> Vector2:
	return spawn_point.global_position

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true;
	display_timer = Timer.new()
	display_timer.one_shot = true
	display_timer.wait_time = 1.5
	display_timer.connect('timeout', on_display_timer_timeout)
	add_child(display_timer)

func get_target() -> Vector2:
	return target

func handle_aim_joystick(delta):
	var dir = Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
	if dir.x < 0.2 and dir.x > 0 and dir.y < 0.2 and dir.y > 0:
		return;
	rotation = lerp_angle(rotation, dir.angle(), 10 * delta)

func handle_aim_mouse(delta):
	look_at(get_global_mouse_position())
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	handle_aim_joystick(delta)
	handle_aim_mouse(delta)
