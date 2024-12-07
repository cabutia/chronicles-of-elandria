class_name EntityStats extends Resource

var SmallStatusbar = preload("res://Objects/SmallStatusbar.tscn")

@export var health = 0
@export var max_health = 100

@export var use_mana = false
@export var mana = 0
@export var max_mana = 100

@export var p_atk = 0;
@export var p_def = 0;
@export var m_atk = 0;
@export var m_def = 0;

signal health_update
signal max_health_update
signal mana_update
signal max_mana_update

var healthbar: SmallStatusbar;

# Initialize for all listeners
func init():
	health_update.emit(health)
	health_update.emit(health)
	mana_update.emit(mana)
	mana_update.emit(mana)

func sub_health(amount: int):
	health = clamp(health - amount, 0, max_health);
	health_update.emit(health)
	
func add_health(amount: int):
	health = clamp(health + amount, 0, max_health);
	health_update.emit(health)
	
func sub_mana(amount: int):
	mana = clamp(mana - amount, 0, max_mana);
	mana_update.emit(mana)
	
func add_mana(amount: int):
	mana = clamp(mana + amount, 0, max_mana);
	mana_update.emit(mana)

func create_healthbar(parent: Node2D, scale: int = 1):
	healthbar = SmallStatusbar.instantiate()
	healthbar.stats_resource = self;
	parent.add_child(healthbar)
	init()
