extends Node2D

@onready var weaponready = false
@onready var timer: Timer = $Timer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D

@onready var weapon_number = GlobalScript.weapon_number
@onready var enemy_meta = []
@onready var enemy_parent = []

@export var damage_amount : float = 50
@export var cooldown_time : float = 1
@export var knockback_decay : float
@export var strenght_amount : float
@export var weapon_range : Vector2 = Vector2(0.5, 80)

func _ready() -> void:
	timer.wait_time = cooldown_time
	collision_shape_2d.position = weapon_range
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		if !timer.is_stopped():
			pass
		else:
			weaponready= true
			GlobalScript.weapon_swing = false
			damage(enemy_meta)
	var angle = (get_global_mouse_position() - global_position).angle()
	if angle >= 1.5:
		sprite_2d.flip_v = true
		sprite_2d.offset = GlobalScript.weapon_offset_left[weapon_number]
		sprite_2d.position = Vector2(28,-68)
	elif angle <= -1.5:
		sprite_2d.flip_v = true
		sprite_2d.offset = GlobalScript.weapon_offset_left[weapon_number]
		sprite_2d.position = Vector2(28,-68)
	else:
		sprite_2d.flip_v = false
		sprite_2d.offset = GlobalScript.weapon_offset_right[weapon_number]
		sprite_2d.position = GlobalScript.weapon_position_right[weapon_number]

func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	var meta = parent.get_meta("character")
	enemy_meta.append(meta)
	enemy_parent.append(parent)

var hit_enemies = []

func damage(meta):

	for i in range(meta.size()):
		if meta[i] == "enemy":
			var enemy = enemy_parent[i]

			if enemy.has_method("take_damage") and weaponready:
				
				if enemy in hit_enemies:
					continue   # skip already hit enemies
				
				enemy.take_damage(damage_amount, self.global_position, knockback_decay, strenght_amount)
				hit_enemies.append(enemy)

	timer.start()
	weaponready = false
	GlobalScript.weapon_swing = true
	
func _on_area_2d_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	var meta = parent.get_meta("character")
	enemy_meta.erase(meta)
	enemy_parent.erase(parent)

func _on_timer_timeout() -> void:
	weaponready = true
	GlobalScript.weapon_swing = false
	hit_enemies.clear()
