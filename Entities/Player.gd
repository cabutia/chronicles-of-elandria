class_name Player extends CharacterBody2D

var bullet_scene = preload("res://Objects/Bullets/Bullet.tscn");
var PlayerStats = preload("res://Entities/PlayerStats.tres")

@onready var entity_map = $"/root/EntityMap";
@onready var world_manager = $"/root/WorldManager";
@onready var inventory_manager = $"/root/InventoryManager";

@onready var character_socket: Node2D = $CharacterPlaceholder;
@onready var label = $Label
@onready var crosshair: Node2D = $PlayerCrosshair;

var timer: Timer;

var character: BaseCharacter;
var speed = 500
var can_move = true;
var can_shoot = true;
var stats: EntityStats = PlayerStats.duplicate();
var type: String

func set_character(type: String):
	var character_scene = entity_map.get_entity(type)
	if !character_scene:
		return
	character = character_scene.instantiate() as BaseCharacter
	for child in character_socket.get_children():
		child.queue_free()
	character_socket.add_child(character)
	
func set_type(_type: String):
	type = _type

func on_world_change_ready(spawn_point: Vector2):
	print('"change ready')
	position = spawn_point

func on_world_change_started():
	print("change started")
	can_move = false

func on_world_change_finished():
	print("change finished")
	can_move = true	

func on_bullet_hit(body):
	if body.is_in_group("enemies"):
		if body.has_method("take_damage"):
			var died = body.take_damage(stats.p_atk)
			if died:
				stats.add_health(10)

func on_shoot():
	if !can_shoot:
		return
	can_shoot = false;
	crosshair.display()
	var bullet: Area2D = bullet_scene.instantiate();
	bullet.position = crosshair.get_spawn_point()
	get_tree().get_root().add_child(bullet);
	bullet.set_target(get_global_mouse_position());
	bullet.connect('body_entered', on_bullet_hit)
	can_shoot = true;

func look_left():
	character.get_sprite().flip_h = true

func look_right():
	character.get_sprite().flip_h = false

func setup_world_manager_signals():
	if world_manager:
		world_manager.connect('change_started', on_world_change_started)
		world_manager.connect('change_finished', on_world_change_finished)
		world_manager.connect('change_ready', on_world_change_ready)
		
func on_pickup(item: DroppedItem):
	inventory_manager.on_pickup_item(item);
	
# Called when the node enters the scene tree for the first time.
func _ready():
	setup_world_manager_signals()
	set_character(type)

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
	
	velocity = direction * speed
	
	if character:
		if velocity == Vector2.ZERO:
			character.play('idle')
		else:
			character.play('walk')
	move_and_slide()
