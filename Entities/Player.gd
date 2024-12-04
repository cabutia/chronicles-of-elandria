class_name Player extends CharacterBody2D

@onready var entity_map = $"/root/EntityMap";
@onready var world_manager = $"/root/WorldManager";

@onready var character_socket: Node2D = $CharacterPlaceholder;
@onready var label = $Label
@onready var crosshair: Node2D = $Crosshair;
@onready var attacking_timeout

var timer: Timer;

var character: BaseCharacter;
var speed = 500
var can_move = true;
var crosshair_hide_delay = 500;

func set_character(type: String):
	var character_scene = entity_map.get_entity(type)
	if !character_scene:
		return
	character = character_scene.instantiate() as BaseCharacter
	# character.global_position = global_position
	for child in character_socket.get_children():
		child.queue_free()
	character_socket.add_child(character)

func on_world_change_ready(spawn_point: Vector2):
	print('"change ready')
	position = spawn_point

func on_world_change_started():
	print("change started")
	can_move = false

func on_world_change_finished():
	print("change finished")
	can_move = true	

func on_shoot():
	crosshair.visible = true;
	timer.start()

func look_left():
	character.get_sprite().flip_h = true

func look_right():
	character.get_sprite().flip_h = false

func setup_world_manager_signals():
	if world_manager:
		world_manager.connect('change_started', on_world_change_started)
		world_manager.connect('change_finished', on_world_change_finished)
		world_manager.connect('change_ready', on_world_change_ready)
		
func on_crosshair_timer_timeout():
	print("on_crosshair_timer_timeout")
	crosshair.visible = false;
		
func setup_crosshair():
	crosshair.visible = false;
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = 1.5
	timer.connect('timeout', on_crosshair_timer_timeout)
	add_child(timer)

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_world_manager_signals()
	setup_crosshair()
	set_character("human")

func _unhandled_input(event):
	if !can_move:
		return
		
	if Input.is_action_just_pressed("player_shoot"):
		on_shoot()
		
	if Input.is_action_just_pressed("player_left"):
		look_left()
	elif Input.is_action_just_pressed("player_right"):
		look_right()
		
func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !can_move:
		return
		
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	crosshair.look_at(get_global_mouse_position())
	
	velocity = direction * speed
	
	if character:
		if velocity == Vector2.ZERO:
			character.play('idle')
		else:
			character.play('walk')
	move_and_slide()
