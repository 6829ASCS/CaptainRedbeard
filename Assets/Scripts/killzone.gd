extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("enemy entered")
	print("Applying knockback to", body.name)
	body.apply_knockback(global_position)
	HealthManager.decrease_health(1)	
	
	if HealthManager.current_health == 0:
		print("player health zero")
		body.player_death()
