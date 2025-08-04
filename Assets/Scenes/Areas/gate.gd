extends StaticBody2D

func _process(delta):
	if Global.special_item_found:
		queue_free()
