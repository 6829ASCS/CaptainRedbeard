extends CharacterBody2D

@export var speed = 20
var direction = 1
@export var move_time = 2
var time_passed = 0.0
@export var x_or_y = "x" 

func _process(delta):
	if x_or_y == "x":
		position.x += direction * speed * delta
	if x_or_y == "y":
		position.y += direction * speed * delta
	time_passed += delta
	if time_passed >= move_time:
		direction *= -1
		time_passed = 0.0
