extends Node2D

var music_bus = AudioServer.get_bus_index("Master")

func _ready():
	AudioServer.set_bus_mute(music_bus, false)

func _on_texture_button_pressed():
	if get_tree().paused:
		get_tree().paused = false
		AudioServer.set_bus_volume_db(music_bus, 0)

	else:
		get_tree().paused = true
		AudioServer.set_bus_volume_db(music_bus, -20)
		
