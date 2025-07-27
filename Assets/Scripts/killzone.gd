extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("enemy entered")
	print("Applying knockback to", body.name)
	body.apply_knockback(global_position)
	HealthManager.decrease_health(1)	
