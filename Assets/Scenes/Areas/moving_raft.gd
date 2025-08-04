extends CharacterBody2D

@export var speed: float = 200.0
@export var move_distance: float = 500.0

var start_position: Vector2
var direction := 1

func _ready():
	start_position = global_position

func _physics_process(delta):
	velocity.x = direction * speed
	move_and_slide()

	if abs(global_position.x - start_position.x) >= move_distance:
		direction *= -1
