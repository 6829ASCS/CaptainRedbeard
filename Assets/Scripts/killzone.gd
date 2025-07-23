extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("You died!")
	call_deferred("_restart_scene")

func _restart_scene():
	get_tree().reload_current_scene()
