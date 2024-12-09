extends Node2D

@onready var game_manager = $"/root/GameManager"
@onready var main_camera: MainCamera = $MainCamera;

# Called when the node enters the scene tree for the first time.
func _ready():
	game_manager.set_main_camera(main_camera)
	game_manager.initialize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
