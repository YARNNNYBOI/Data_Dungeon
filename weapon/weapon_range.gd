extends Node2D

# ==================================================
# NODE REFERENCES
# ==================================================
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D

# ==================================================
# WEAPON CONFIG
# ==================================================
@onready var weapon_number = GlobalScript.weapon_number
@export var enemy_type : String
@export var weapon_range : Vector2
@export var cooldown_time : float = 1
@export var knockback_decay = 500
@export var strenght_amount = 200
@export var damage_amount = 5 
@export var speed = 150
@export var scales : Vector2
@onready var projectile_scene = preload("res://weapon/projectile.tscn")

# ==================================================
# STATE
# ==================================================
var weaponready = true

# ==================================================
# READY
# ==================================================
func _ready() -> void:
	timer.wait_time = cooldown_time

# ==================================================
# PROCESS
# ==================================================
func _process(delta: float) -> void:
	var dir = get_global_mouse_position() - global_position
	var angle = dir.angle()

	# Flip / rotate weapon like melee
	if angle >= 1.5:
		sprite_2d.flip_v = true
		sprite_2d.offset = GlobalScript.weapon_offset_left[weapon_number]
		sprite_2d.rotation = GlobalScript.weapon_rotation_left[weapon_number]
	elif angle <= -1.5:
		sprite_2d.flip_v = true
		sprite_2d.offset = GlobalScript.weapon_offset_left[weapon_number]
		sprite_2d.rotation = GlobalScript.weapon_rotation_left[weapon_number]
	else:
		sprite_2d.flip_v = false
		sprite_2d.offset = GlobalScript.weapon_offset_right[weapon_number]
		sprite_2d.rotation = GlobalScript.weapon_rotation_right[weapon_number]

	# Handle attack input
	if Input.is_action_just_pressed("attack") and weaponready:
		fire_projectile()
		weaponready = false
		GlobalScript.weapon_swing = true
		timer.start()

# ==================================================
# PROJECTILE SPAWN
# ==================================================
func fire_projectile() -> void:
	var projectile = projectile_scene.instantiate()
	var target = get_global_mouse_position()
	var dir = (target - global_position).normalized()

	projectile.direction = dir
	projectile.rotation = dir.angle()
	projectile.global_position = global_position
	projectile.damage = damage_amount
	projectile.enemy_type = enemy_type
	projectile.knockback_decay = knockback_decay
	projectile.strenght_amount = strenght_amount
	projectile.speed = speed

	projectile.get_node("AnimatedSprite2D").play("arrow")
	get_tree().current_scene.add_child(projectile)

# ==================================================
# TIMER TIMEOUT
# ==================================================
func _on_timer_timeout() -> void:
	weaponready = true
	GlobalScript.weapon_swing = false
