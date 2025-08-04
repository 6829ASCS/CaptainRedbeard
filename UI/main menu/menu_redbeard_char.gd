extends Sprite2D

@export var max_angle_degrees := 5.0
@export var duration := 1.0  # seconds for half swing

func _ready():
	_start_rocking()

func _start_rocking():
	var tween = create_tween()
	tween.tween_property(self, "rotation", deg_to_rad(max_angle_degrees), duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "rotation", deg_to_rad(-max_angle_degrees), duration)\
		.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.set_loops()
