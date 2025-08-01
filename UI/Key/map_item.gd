extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		
		Global.special_item_found = true
		Global.special_item_collected.emit()

		
		$CollisionShape2D.set_deferred("disabled", true)
	
		var tween = get_tree().create_tween()
		var up_pos = global_position + Vector2(0, -300)
		var down_pos = global_position + Vector2(0, -150)

		tween.tween_property(self, "global_position", up_pos, 0.4)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		tween.tween_property(self, "global_position", down_pos, 0.3)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

		tween.parallel().tween_property(self, "modulate:a", 0.0, 0.3)\
			.set_trans(Tween.TRANS_LINEAR)

		tween.tween_callback(Callable(self, "queue_free"))
