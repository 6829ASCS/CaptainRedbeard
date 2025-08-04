extends Area2D

@export var raise_distance := 300.0
@export var raise_duration := 0.5

var raised := false

func _on_body_entered(body):
	if raised:
		return
	if body.is_in_group("Player"):
		raised = true
		$CollisionPolygon2D.set_deferred("disabled", true)
		$AudioStreamPlayer2D.play()
		var tween = get_tree().create_tween()
		var target_pos = global_position + Vector2(0, -raise_distance)

		tween.tween_property(self, "global_position", target_pos, raise_duration)\
			.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

		tween.tween_callback(Callable(self, "_on_flag_raised"))

func _on_flag_raised():
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://UI/main menu/main_menu.tscn")
