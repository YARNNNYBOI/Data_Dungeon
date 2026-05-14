extends CharacterBody2D
@onready var player
@onready var enemy_weapon: Node2D = $enemy_weapon
@onready var enemy_sprite: AnimatedSprite2D = $enemy_sprite
@onready var color_timer: Timer = $color_timer

@onready var hasSpawned = false

@export var stage = 2
@export var stop_distance = 20
@export var health = 100
@export var room_group: String
var chasing = false
var speed = 50

@export var knockback_decay: float = 500
@export var strength_amount: float = 200
var knockback_velocity: Vector2 = Vector2.ZERO
var is_knockedback = false

func _ready() -> void:
	add_to_group(room_group)
	set_meta("character", "enemy")
	var players = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		player = players[0] as CharacterBody2D
	else:
		push_error("No nodes in 'players' group found!")

func take_damage(amount: int, source_position: Vector2, knockback_decay, strength_amount):
	health -= amount
	print("enemy health: ", health)
	damage_effect()
	check_status()

	# Apply knockback
	var direction = (global_position - source_position).normalized()
	knockback_velocity = direction * strength_amount
	is_knockedback = true  # lock movement immediately

func _physics_process(delta):
		if is_spawning:
			return  # 🚫 STOP EVERYTHING during spawn

		var move_vector = Vector2.ZERO

		if chasing and not is_knockedback and player:
			var dir_to_player = player.global_position - global_position
			if dir_to_player.length() > stop_distance:
				move_vector = dir_to_player.normalized() * speed

		velocity = move_vector + knockback_velocity

	# Only play animations if NOT spawning
		if move_vector != Vector2.ZERO:
			enemy_sprite.play("walking")
		else:
			enemy_sprite.play("idle")

		move_and_slide()

		if knockback_velocity.length() > 0:
			enemy_sprite.play("idle")
			is_knockedback = true
			var decay = knockback_decay * delta
			if knockback_velocity.length() <= decay:
				knockback_velocity = Vector2.ZERO
				is_knockedback = false
			else:
				knockback_velocity -= knockback_velocity.normalized() * decay

		if player:
			enemy_weapon.look_at(player.global_position)

func damage_effect():
	enemy_sprite.modulate = Color(1.0, 0.078, 0.082, 1.0)  # white
	color_timer.start()

var is_spawning = false

func play_spawn_effect():
	visible = true
	is_spawning = true
	chasing = false

	if enemy_sprite.sprite_frames.has_animation("spawn") and !hasSpawned:
		print("spawning")
		enemy_sprite.play("spawn")
		await enemy_sprite.animation_finished
		hasSpawned = true
	else:
		print("no animation sadly")

	is_spawning = false
	chasing = true
	set_process(true) # ← ONLY enable after spawn

func check_status():
	if health <= 0:
		GlobalScript.room1enemies += 1
		queue_free()

func _on_color_timer_timeout() -> void:
	enemy_sprite.modulate = Color(1, 1, 1, 1)
