extends CharacterBody2D
@onready var player
@onready var enemy_weapon: Node2D = $enemy_weapon
@onready var enemy_sprite: AnimatedSprite2D = $enemy_sprite
@onready var color_timer: Timer = $color_timer

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
		enemy_sprite.play("idle")
		is_knockedback = true
		var decay = knockback_decay * delta
		if knockback_velocity.length() <= decay:
			knockback_velocity = Vector2.ZERO
			is_knockedback = false
		else:
			knockback_velocity -= knockback_velocity.normalized() * decay
		
	# Rotate weapon toward player
	if player:
		enemy_weapon.look_at(player.global_position)

func damage_effect():
	enemy_sprite.modulate = Color(1.0, 0.078, 0.082, 1.0)  # white
	color_timer.start()

func check_status():
	if health <= 0:
		GlobalScript.room1enemies += 1
		queue_free()

func _on_color_timer_timeout() -> void:
	enemy_sprite.modulate = Color(1, 1, 1, 1)
