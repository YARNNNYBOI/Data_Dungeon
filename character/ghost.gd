extends CharacterBody2D
@onready var player
@onready var enemy_sprite: AnimatedSprite2D = $enemy_sprite
@onready var color_timer: Timer = $color_timer
@onready var throwing_timer: Timer = $throwing_timer

@onready var is_spawning = false

@onready var goo_instance = preload("res://character/abilities/ghost_goo.tscn")

@export var stage = 2
@export var stop_distance = 40
@export var health = 100
@export var room_group: String
var chasing = false
var speed = 50

@export var knockback_decay: float = 500
@export var strength_amount: float = 200
var knockback_velocity: Vector2 = Vector2.ZERO
var is_knockedback = false
var player_last_location : Vector2

var timer_started = false

func _ready() -> void:
	add_to_group(room_group)
	set_meta("character", "enemy")
	var players = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		player = players[0] as CharacterBody2D
	else:
		push_error("No nodes in 'players' group found!")
		
func _process(delta: float) -> void:
	var move_vector = Vector2.ZERO

	# Only chase if not knocked back and player exists
	if chasing and not is_knockedback and player:
		var dir_to_player = player.global_position - global_position
		if dir_to_player.length() > stop_distance:
			move_vector = dir_to_player.normalized() * speed

	# Add knockback
	velocity = move_vector + knockback_velocity
	enemy_sprite.play("walking")
	move_and_slide()

	# Reduce knockback gradually
	if knockback_velocity.length() > 0:
		enemy_sprite.play("walking")
		is_knockedback = true
		var decay = knockback_decay * delta
		if knockback_velocity.length() <= decay:
			knockback_velocity = Vector2.ZERO
			is_knockedback = false
		else:
			knockback_velocity -= knockback_velocity.normalized() * decay
		
	if player:
		if !timer_started:
			chasing = true
			timer_started = true
			throwing_timer.start()

func take_damage(amount: int, source_position: Vector2, knockback_decay, strength_amount):
	health -= amount
	print("enemy health: ", health)
	damage_effect()
	check_status()

	# Apply knockback
	var direction = (global_position - source_position).normalized()
	knockback_velocity = direction * strength_amount
	is_knockedback = true  # lock movement immediately

func damage_effect():
	enemy_sprite.modulate = Color(1.0, 0.078, 0.082, 1.0)  # white
	color_timer.start()

func check_status():
	if health <= 0:
		GlobalScript.room1enemies += 1
		queue_free()

func play_spawn_effect():
	print("here")
	visible = true
	is_spawning = true
	chasing = false

	if enemy_sprite.sprite_frames.has_animation("spawn"):
		print("spawning")
		enemy_sprite.play("spawn")
		await enemy_sprite.animation_finished
	else:
		print("no animation sadly")

	is_spawning = false
	chasing = true
	set_process(true) # ← ONLY enable after spawn

func _on_timer_timeout() -> void:
	enemy_sprite.modulate = Color(1, 1, 1, 1)


func _on_throwing_timer_timeout() -> void:
	player_last_location = player.global_position
	var goo = goo_instance.instantiate()
	goo.setup(global_position, player_last_location)
	get_tree().current_scene.add_child(goo)
	timer_started = false
	is_knockedback = false
