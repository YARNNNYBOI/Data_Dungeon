extends CharacterBody2D
@onready var player
@onready var enemy_sprite: AnimatedSprite2D = $enemy_sprite
@onready var color_timer: Timer = $color_timer
@onready var throwing_timer: Timer = $throwing_timer
@onready var teleport_timer: Timer = $teleport_timer
@export var enemy_type : String

@onready var purple_orb_instance = preload("res://weapon/projectile.tscn")
@onready var purple_orb_text = preload("res://weapon/cultistorb.png")

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
		enemy_sprite.play("idle")
		is_knockedback = true
		var decay = knockback_decay * delta
		if knockback_velocity.length() <= decay:
			knockback_velocity = Vector2.ZERO
			is_knockedback = false
		else:
			knockback_velocity -= knockback_velocity.normalized() * decay
	if player:
		if player.global_position.x < global_position.x:
			enemy_sprite.flip_h = true   # player is left
		else:
			enemy_sprite.flip_h = false  # player is right
		
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


func _on_color_timer_timeout() -> void:
	enemy_sprite.modulate = Color(1, 1, 1, 1)



func _on_throwing_timer_timeout() -> void:
	player_last_location = player.global_position
	var orb = purple_orb_instance.instantiate()
	orb.get_node("AnimatedSprite2D").play("purpleorb")
	orb.setup(global_position, player_last_location)
	orb.enemy_type = enemy_type
	get_tree().current_scene.add_child(orb)
	timer_started = false
	is_knockedback = false
	teleport_timer.start()

func _on_teleport_timer_timeout() -> void:
	var offset = Vector2(
		randf_range(-20, 20),
		randf_range(-20, 20)
	)

	self.global_position = player.global_position + offset
