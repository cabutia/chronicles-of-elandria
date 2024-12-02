class_name Player extends CharacterBody2D

@onready var entity_map = $"/root/EntityMap";

@onready var character_socket: Node2D = $CharacterPlaceholder;
@onready var label = $Label

var character: BaseCharacter;
var speed = 500

func set_character(type: String):
	var character_scene = entity_map.get_entity(type)
	if !character_scene:
		pass
	character = character_scene.instantiate() as BaseCharacter
	# character.global_position = global_position
	character_socket.add_child(character)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("player_left"):
		character.get_sprite().flip_h = true
	elif Input.is_action_just_pressed("player_right"):
		character.get_sprite().flip_h = false
		
func _process(delta):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")
	
	velocity = direction * speed
	
	if character:
		if velocity == Vector2.ZERO:
			character.play('idle')
		else:
			character.play('walk')
	move_and_slide()
