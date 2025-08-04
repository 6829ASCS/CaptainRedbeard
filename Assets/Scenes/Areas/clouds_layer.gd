extends ParallaxLayer

@export var CLOUD_SPEED = -50

func _process(delta: float) -> void:
	self.motion_offset.x += CLOUD_SPEED * delta
