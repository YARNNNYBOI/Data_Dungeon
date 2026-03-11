extends Node2D
@onready var timer: Timer = $Timer


@onready var projectile_scene = preload("res://weapon/projectile.tscn")
@onready var weaponready = true
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var weapon_number = GlobalScript.weapon_number
@export var enemy_type : String
@export var weapon_range :Vector2
@export var cooldown_time : float
@export var knockback_decay = 500
@export var strenght_amount = 200
@export var damage_amount = 5 
@export var speed = 150

func _ready() -> void:
	timer.wait_time = cooldown_time

func _process(delta: float) -> void:
	print(timer.time_left)
	if Input.is_action_just_pressed("attack"):
		if timer.is_stopped():
			shoot()
			timer.start()
		elif timer.wait_time > 0.001:
			print("cooldown")
			
	var dir = get_global_mouse_position() - global_position

	var angle = (get_global_mouse_position() - global_position).angle()
	if angle >= 1.5:
		sprite_2d.flip_v = true
		sprite_2d.offset = GlobalScript.weapon_offset_left[weapon_number]
		
		sprite_2d.rotation = GlobalScript.weapon_rotation_left[weapon_number]
	elif angle <= -1.5:
		sprite_2d.flip_v = true
		sprite_2d.offset = GlobalScript.weapon_offset_left[weapon_number]
		sprite_2d.position = GlobalScript.weapon_position_left[weapon_number]
		sprite_2d.rotation = GlobalScript.weapon_rotation_left[weapon_number]
	else:
		sprite_2d.flip_v = false
		sprite_2d.offset = GlobalScript.weapon_offset_right[weapon_number]
		sprite_2d.position = GlobalScript.weapon_position_right[weapon_number]
		sprite_2d.rotation = GlobalScript.weapon_rotation_right[weapon_number]

func shoot():
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

	projectile.get_node("Sprite2D").texture = load(GlobalScript.projectile[weapon_number])

	get_tree().current_scene.add_child(projectile)
	

func _on_color_timer_timeout() -> void:
	pass
