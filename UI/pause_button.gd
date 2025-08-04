extends Node2D

@onready var home_button := $HomeButton
var music_bus = AudioServer.get_bus_index("Master")

func _ready():
	HealthManager.current_health = HealthManager.max_health
	Global.score = 0
	home_button.visible = false
	get_tree().paused = false
	AudioServer.set_bus_volume_db(music_bus, 0)
	AudioServer.set_bus_mute(music_bus, false)

func _on_texture_button_pressed():
	if get_tree().paused:
		get_tree().paused = false
		AudioServer.set_bus_volume_db(music_bus, 0)
		home_button.visible = false

	else:
		get_tree().paused = true
		AudioServer.set_bus_volume_db(music_bus, -20)
		home_button.visible = true
	
func _on_home_button_pressed() -> void:
	AudioServer.set_bus_volume_db(music_bus, 0)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/main menu/main_menu.tscn")
