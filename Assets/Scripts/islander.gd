extends Node2D

@onready var anim = $AnimatedSprite2D

var speed = 250
var direction = 1  # Start moving right
var move_time = 4.0 # seconds before changing direction
var time_passed = 0.0

func _process(delta):
	# Move manually
	position.x += direction * speed * delta

	# Animate
	anim.play("default")
	anim.flip_h = direction < 0  # Flip when moving left

	# Flip direction after move_time seconds
	time_passed += delta
	if time_passed >= move_time:
		direction *= -1
		time_passed = 0.0


func _on_stomp_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":	
		print("dead enemy")
		body.bounce_after_stomp()
		queue_free()
