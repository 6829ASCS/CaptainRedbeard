extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("+1 coin")
		ScoreCounter.score = ScoreCounter.score + 1
		queue_free()
