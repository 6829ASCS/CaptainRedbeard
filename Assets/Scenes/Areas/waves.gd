extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		HealthManager.decrease_health(3)
		body.player_death()	
