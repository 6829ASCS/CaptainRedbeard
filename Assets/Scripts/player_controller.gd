extends CharacterBody2D

@export var speed = 10.0
@export var jump_power = 10.0

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0

@onready var animated_sprite_2d: AnimatedSprite2D = $Node2D/AnimatedSprite2D

@onready var sword_anim_player: AnimatedSprite2D = $Sword/SwordAnimPlayer
@onready var sword: Area2D = $Sword

var is_knockback = false
var knockback_timer = 0.0
const KNOCKBACK_FORCE = 2500.0
const KNOCKBACK_DURATION = 0.2

var dead = false

func _ready():
	pass	

func _physics_process(delta: float) -> void:
	if dead:
		velocity = Vector2.ZERO
		move_and_slide()
		return
		
	if is_knockback:
		knockback_timer -= delta
		animated_sprite_2d.play("fall")
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
			animated_sprite_2d.flip_h = direction < 0
			sword.scale.x = -1 if direction < 0 else 1


		else:
			velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)
		
		#if Input.is_action_just_pressed("attack") and is_on_floor():
			#sword_anim_player.play("swing")
		
		# Determine animation based on movement
		if not is_on_floor():
			if velocity.y < 0:
				animated_sprite_2d.play("jump")
			else:
				animated_sprite_2d.play("fall")
		elif direction:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
	sword_anim_player.visible = is_on_floor()
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
	
func player_death():
	dead = true
	Engine.time_scale = 0.1
	animated_sprite_2d.play("death")
	sword_anim_player.hide()
	set_collision_layer(0)
	set_collision_mask(0)
	Global.emit_signal("player_died")
	await animated_sprite_2d.animation_finished
	Engine.time_scale = 1
	Global.score = 0
	HealthManager.current_health = HealthManager.max_health
	Global.special_item_found = false
	get_tree().reload_current_scene()
