extends Label

@onready var world_manager = $"/root/WorldManager";

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	world_manager.connect("change_started", on_change_started)
	world_manager.connect("change_ready", on_change_ready)

func on_change_started():
	visible = true
	text = "Traveling to %s" % world_manager.get_target_world_name()
	
func on_change_ready(_name):
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
