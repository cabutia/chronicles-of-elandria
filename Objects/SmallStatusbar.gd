class_name SmallStatusbar extends Node2D

@export var stats_resource: EntityStats;

@onready var health_progress_bar: ProgressBar = $HealthProgressBar;
@onready var mana_progress_bar: ProgressBar = $ManaProgressBar;

# Called when the node enters the scene tree for the first time.
func _ready():
	if stats_resource:
		stats_resource.connect('health_update', on_health_update)
		stats_resource.connect('max_health_update', on_max_health_update)
		stats_resource.connect('mana_update', on_mana_update)
		stats_resource.connect('max_mana_update', on_max_mana_update)
		
		if !stats_resource.use_mana:
			mana_progress_bar.visible = false;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_health_update(amount: int):
	health_progress_bar.value = amount
	
func on_max_health_update(amount: int):
	health_progress_bar.max_value = amount
	
func on_mana_update(amount: int):
	mana_progress_bar.value = amount;
	
func on_max_mana_update(amount: int):
	mana_progress_bar.max_value = amount;
	
