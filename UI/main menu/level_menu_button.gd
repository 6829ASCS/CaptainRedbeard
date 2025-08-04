extends TextureButton

@export var level_scene_path: String = ""

@onready var audio_player: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

var click_sound = preload("res://Assets/Audios/click sound.mp3")
var hover_sound = preload("res://Assets/Audios/hover sound.mp3")

func _ready():
	pivot_offset = size / 2
	scale = Vector2.ONE
	
func _on_mouse_entered():
	audio_player.stream = hover_sound
	audio_player.play()
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.1, 1.1), 0.1)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _on_mouse_exited():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	
func _on_pressed():
	audio_player.stream = click_sound
	if level_scene_path != "":
		audio_player.play()	
		await get_tree().create_timer(0.1).timeout
		get_tree().change_scene_to_file(level_scene_path)

	else:
		var original_pos = position
		var tween = create_tween()
		tween.tween_property(self, "position", original_pos + Vector2(-5, 0), 0.05)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "position", original_pos + Vector2(5, 0), 0.05)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "position", original_pos + Vector2(-3, 0), 0.04)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		tween.tween_property(self, "position", original_pos, 0.04)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
