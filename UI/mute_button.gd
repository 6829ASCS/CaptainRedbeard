extends Node2D

var music_bus = AudioServer.get_bus_index("Master")

func _ready():
	AudioServer.set_bus_mute(music_bus, false)

func _on_texture_button_pressed() -> void:
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
