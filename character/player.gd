extends CharacterBody2D

# ==================================================
# NODE REFERENCES
# ==================================================

@onready var timer: Timer = $Timer
@onready var color_timer: Timer = $color_timer
@onready var weapon_timer: Timer = $weapon_timer

@onready var player_sprite: AnimatedSprite2D

@onready var description_text: Label = $CanvasLayer/Info_Screen/ColorRect/description_text
@onready var title_text: Label = $CanvasLayer/Info_Screen/ColorRect/Title

@onready var death_screen: Control = $"CanvasLayer/Death Screen"
@onready var gui: Control = $CanvasLayer/GUI
@onready var info_screen: Control = $CanvasLayer/Info_Screen

@onready var cooldown_bar = $CanvasLayer/GUI/ProgressBar
@onready var health_bar: ProgressBar = $CanvasLayer/GUI/health

# INVENTORY PREFAB
@onready var inventory_scene = preload("res://GUI/inventory.tscn")
var inventory_instance

# ==================================================
# EXPORTED VARIABLES
# ==================================================

@export var cooldown : float = 0.2
@export var knockback_decay: float = 500
@export var strenght_amount : int

# ==================================================
# GLOBAL STATS
# ==================================================

@onready var health = GlobalScript.health
@onready var speed = GlobalScript.speed

# ==================================================
# PLAYER STATE
# ==================================================

var knockback_velocity: Vector2 = Vector2.ZERO
var isWeaponInUse = false
var is_knockedback = false
var isInventoryOpen = false

# ==================================================
# WEAPON + CHARACTER DATA
# ==================================================

@onready var number_weapon = GlobalScript.weapon_number
@onready var weapon_scene = load(GlobalScript.weapon[number_weapon])
@onready var sprite_scene = load(GlobalScript.character_sprite[number_weapon])

# ==================================================
# RUNTIME INSTANCES
# ==================================================

var weapon_instance: Node2D = null
var sprite_instance: AnimatedSprite2D

# ==================================================
# READY
# ==================================================

func _ready() -> void:
	GlobalScript.can_move = true
	cooldown_bar.max_value = weapon_timer.wait_time

	if timer:
		timer.wait_time = cooldown
	else:
		push_error("Timer not found!")

	death_screen.visible = false
	gui.visible = true
	info_screen.visible = false

	set_meta("character", "player")

	health_bar.value = GlobalScript.health

	# Spawn player sprite
	if sprite_scene:
		sprite_instance = sprite_scene.instantiate()
		add_child(sprite_instance)
		player_sprite = sprite_instance

	# Spawn weapon
	if weapon_scene:
		weapon_instance = weapon_scene.instantiate()

		weapon_instance.get_node("Sprite2D").texture = load(GlobalScript.weaponsprite[number_weapon])
		weapon_instance.get_node("Sprite2D").offset = GlobalScript.weapon_offset_right[number_weapon]
		weapon_instance.get_node("Sprite2D").position = GlobalScript.weapon_position_right[number_weapon]
		weapon_instance.get_node("Sprite2D").rotation = GlobalScript.weapon_rotation_right[number_weapon]
		weapon_instance.get_node("Sprite2D").scale = GlobalScript.weapon_scale[number_weapon]

		weapon_instance.damage_amount = GlobalScript.weapon_damage[number_weapon]
		weapon_instance.cooldown_time = GlobalScript.weapon_cooldown[number_weapon]
		weapon_instance.weapon_range = GlobalScript.weapon_range[number_weapon]

		weapon_instance.knockback_decay = GlobalScript.knockback_decay[number_weapon]
		weapon_instance.strenght_amount = GlobalScript.strength_amount[number_weapon]

		if weapon_instance.get("speed") != null:
			weapon_instance.set("speed", GlobalScript.projectile_speed[number_weapon])

		add_child(weapon_instance)
		weapon_instance.position = Vector2.ZERO

	# SPAWN INVENTORY UI
	inventory_instance = inventory_scene.instantiate()
	$CanvasLayer.add_child(inventory_instance)
	inventory_instance.visible = false


# ==================================================
# PHYSICS
# ==================================================


func _physics_process(delta):
	# Only allow inventory toggle if no pedestal is blocking
	var pedestal_blocking := false
	pedestal_blocking = InventoryScript.can_access_inventory

	if Input.is_action_just_pressed("interact") and GlobalScript.on_pedestal:
		toggle_inventory()

	var input_vector = Vector2.ZERO

	if GlobalScript.can_move:

		if not is_knockedback:

			input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

			input_vector = input_vector.normalized() * GlobalScript.speed

		velocity = input_vector + knockback_velocity
		move_and_slide()

		if knockback_velocity.length() > 0:

			var decay = knockback_decay * delta

			if knockback_velocity.length() <= decay:
				knockback_velocity = Vector2.ZERO
				is_knockedback = false
			else:
				knockback_velocity -= knockback_velocity.normalized() * decay

	update_animation()

# ==================================================
# FRAME PROCESS
# ==================================================

func _process(delta):

	if GlobalScript.weapon_swing and !isWeaponInUse:
		pass
	else:
		weapon_timer.start()

	if weapon_instance:
		weapon_instance.look_at(get_global_mouse_position())

	update_ui()

# ==================================================
# UI
# ==================================================

func update_ui():

	health_bar.value = GlobalScript.health
	cooldown_bar.value = weapon_timer.time_left

# ==================================================
# ANIMATION
# ==================================================

func update_animation():

	if velocity.length() == 0:
		player_sprite.stop()
		return

	if abs(velocity.y) > abs(velocity.x):

		if velocity.y > 0:
			player_sprite.play("walking_down")
			weapon_instance.z_index = 1
		else:
			player_sprite.play("walking_up")
			weapon_instance.z_index = -1

	else:

		if velocity.x > 0:
			player_sprite.play("walking_right")
		else:
			player_sprite.play("walking_left")

# ==================================================
# DAMAGE / STATUS
# ==================================================

func take_damage(amount, source_position, knockback_decay, strenght_amount):

	GlobalScript.health -= amount

	damage_effect()

	print("Health:", GlobalScript.health)

	check_status()

	var direction = (global_position - source_position).normalized()
	var strength = strenght_amount

	knockback_velocity = direction * strength
	is_knockedback = true


func damage_effect():

	player_sprite.modulate = Color(255,0,0)
	color_timer.start()


func _on_color_timer_timeout():

	player_sprite.modulate = Color(1,1,1,1)


func check_status():

	if GlobalScript.health <= 0:
		GlobalScript.can_move = false
		gui.visible = false
		death_screen.visible = true


# ==================================================
# INVENTORY
# ==================================================

func toggle_inventory():
	
	if !GlobalScript.using_pedestal:
		GlobalScript.can_move = false
		inventory_instance.visible = true
		GlobalScript.using_pedestal = true
	else:
		GlobalScript.can_move = true
		inventory_instance.visible = false
		GlobalScript.using_pedestal = false
		
# ==================================================
# UI EVENTS
# ==================================================

func show_info_screen(title, description):

	title_text.text = title
	description_text.text = description
	info_screen.visible = true
	GlobalScript.can_move = false
	

func _on_button_1_pressed():

	info_screen.visible = false
	GlobalScript.can_move = true


func _on_texture_button_pressed() -> void:
	GlobalScript.health = health
	GlobalScript.speed = speed
	get_tree().change_scene_to_file("res://stages/main_area.tscn")
