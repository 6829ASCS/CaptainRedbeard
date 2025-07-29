extends Area2D

var StudPickUpSound = preload("res://Assets/Audios/stud sound.mp3")
const FLOAT_TARGET = Vector2(-8000, -15000)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("+1 coin")
		ScoreCounter.score = ScoreCounter.score + 1
		
		$AudioStreamPlayer2D.stream = StudPickUpSound
		$AudioStreamPlayer2D.play()
		$CollisionShape2D.set_deferred("disabled", true)
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", FLOAT_TARGET, 8)
		tween.connect("finished", Callable(self, "queue_free"))
