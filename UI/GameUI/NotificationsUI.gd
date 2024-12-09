extends Control

var NotificationMessageScn = preload("res://UI/GameUI/NotificationMessage.tscn")

@onready var game_manager = $"/root/GameManager"
@onready var message_container = $MessageContainer

func add_message(message: String):
	var label = NotificationMessageScn.instantiate()
	label.set_message(message)
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = true
	timer.wait_time = 3
	timer.connect("timeout", func(): label.queue_free())
	message_container.add_child(label)
	add_child(timer)

func _ready():
	game_manager.connect("on_send_message", add_message)
