extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $Killzone/CollisionShape2D
@export var damage_amount : int = 1

var DeathSound = preload("res://Assets/Audios/lego-breaking.mp3")

var speed = 250
var direction = 1  # Start moving right
var move_time = 4.0 # seconds before changing direction
var time_passed = 0.0
var is_dead = false


func _process(delta):
	# Move manually
	if is_dead == true:
		return
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
	if body.name == "Player" and is_dead != true:	
		$AudioStreamPlayer2D.stream = DeathSound
		$AudioStreamPlayer2D.play()
		print("dead enemy")
		body.bounce_after_stomp()
		is_dead = true
		$Killzone.collision_mask = 0
		$CharacterBody2D.collision_layer = 0
		anim.play("death")
		await anim.animation_finished
		anim.frame = 2
