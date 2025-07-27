extends CharacterBody2D

@export var speed = 10.0
@export var jump_power = 10.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/AnimatedSprite2D

var is_knockback = false
var knockback_timer = 0.0
const KNOCKBACK_FORCE = 2500.0
const KNOCKBACK_DURATION = 0.2


func _ready():
	pass	

#const SPEED = 300.0
#const JUMP_VELOCITY = -400.0 


func _physics_process(delta: float) -> void:
	if is_knockback:
		knockback_timer -= delta
		if knockback_timer <= 0:
			is_knockback = false
	else:
		if not is_on_floor():
			velocity += get_gravity() * delta

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_power * jump_multiplier

		direction = Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * speed * speed_multiplier
			animated_sprite_2d.play("run")
			animated_sprite_2d.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
			animated_sprite_2d.play("idle")

	move_and_slide()


func bounce_after_stomp():
	velocity.y = -1500

func apply_knockback(from_position: Vector2):
	print("Knockback applied from:", from_position)
	var direction = (global_position - from_position).normalized()

	# Add upward force regardless of angle
	var knockback = direction * KNOCKBACK_FORCE
	knockback.y = -abs(KNOCKBACK_FORCE * 0.3)  # Force upward component

	velocity = knockback
	is_knockback = true
	knockback_timer = KNOCKBACK_DURATION
