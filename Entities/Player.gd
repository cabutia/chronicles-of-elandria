class_name Player extends CharacterBody2D

@onready var entity_map = $"/root/EntityMap";
@onready var world_manager = $"/root/WorldManager";

@onready var character_socket: Node2D = $CharacterPlaceholder;
@onready var label = $Label

var character: BaseCharacter;
var speed = 500
var can_move = true;

func set_character(type: String):
	var character_scene = entity_map.get_entity(type)
	if !character_scene:
		pass
	character = character_scene.instantiate() as BaseCharacter
	# character.global_position = global_position
	character_socket.add_child(character)

# Called when the node enters the scene tree for the first time.
func _ready():
	world_manager.connect('change_started', on_world_change_started)
	world_manager.connect('change_finished', on_world_change_finished)
	world_manager.connect('change_ready', on_world_change_ready)
	
func on_world_change_ready(spawn_point: Vector2):
	print('"change ready')
	position = spawn_point
	
func on_world_change_started():
	print("change started")
	can_move = false
	
func on_world_change_finished():
	print("change finished")
	can_move = true	
	
func _unhandled_input(event):
	if !can_move:
		return
	if Input.is_action_just_pressed("player_left"):
		character.get_sprite().flip_h = true
	elif Input.is_action_just_pressed("player_right"):
		character.get_sprite().flip_h = false
		
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
