extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var level1_soundtrack = preload("res://Assets/Audios/Tropical Loop for a Game.wav")
var death_sound = preload("res://Assets/Audios/GTA wasted sound effect - no copyright HD (mp3cut.net).mp3.mp3")

func _ready():
	Global.player_died.connect(_on_player_died)
	audio_stream_player.stream = level1_soundtrack
	audio_stream_player.play()
	
func _on_player_died() -> void:
	audio_stream_player.stream = death_sound
	audio_stream_player.play()
