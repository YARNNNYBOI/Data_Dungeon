extends CharacterBody2D


@onready var timer: Timer = $Timer
@onready var color_timer: Timer = $color_timer
@onready var player_sprite: AnimatedSprite2D 

@export var cooldown = .2

@onready var death_screen: Control = $"CanvasLayer/Death Screen"
@onready var gui: Control = $CanvasLayer/GUI
@onready var inventory: Control = $CanvasLayer/Inventory

@onready var cooldown_bar = $CanvasLayer/GUI/ProgressBar
@onready var health_bar: ProgressBar = $CanvasLayer/GUI/health
@onready var weapon_timer = $weapon_timer

@onready var info_screen: Control = $CanvasLayer/Info_Screen
@onready var h_box_container: HBoxContainer = $CanvasLayer/Inventory/HBoxContainer


@export var knockback_decay: float = 500
@export var strenght_amount : int
var knockback_velocity: Vector2 = Vector2.ZERO

var isWeaponInUse = false
var is_knockedback = false

@onready var number_weapon = GlobalScript.weapon_number
@onready var weapon_scene = load(GlobalScript.weapon[number_weapon])

@onready var sprite_scene = load(GlobalScript.character_sprite[number_weapon])
@onready var health = GlobalScript.health
@onready var speed = GlobalScript.speed

var weapon_instance: Node2D = null
var sprite_instance: AnimatedSprite2D

func _ready() -> void:
	cooldown_bar.max_value = weapon_timer.wait_time
	inventory.visible = false
	death_screen.visible = false
	gui.visible = true
	info_screen.visible = false
	timer.wait_time = cooldown
	set_meta("character", "player")
	health_bar.value = GlobalScript.health
	
	if sprite_scene:
		sprite_instance = sprite_scene.instantiate()
		add_child(sprite_instance)
		player_sprite = sprite_instance
	# Spawn weapon if weapon_scene is assigned
	if weapon_scene:
		weapon_instance = weapon_scene.instantiate() as Node2D
		weapon_instance.get_node("Sprite2D").texture = load(GlobalScript.weaponsprite[number_weapon])
		weapon_instance.get_node("Sprite2D").offset = GlobalScript.weapon_offset_right[number_weapon]
		weapon_instance.get_node("Sprite2D").position = GlobalScript.weapon_position_right[number_weapon]
		weapon_instance.get_node("Sprite2D").rotation = GlobalScript.weapon_rotation_right[number_weapon]
		weapon_instance.damage_amount = GlobalScript.weapon_damage[number_weapon]
		weapon_instance.cooldown_time = GlobalScript.weapon_cooldown[number_weapon]
		weapon_instance.weapon_range = GlobalScript.weapon_range[number_weapon]
		weapon_instance.knockback_decay = GlobalScript.knockback_decay[number_weapon]
		weapon_instance.strenght_amount = GlobalScript.strength_amount[number_weapon]
		if weapon_instance.get("speed") != null:
			weapon_instance.set("speed", GlobalScript.projectile_speed[number_weapon])
		add_child(weapon_instance)  # attach it to the player
		weapon_instance.position = Vector2.ZERO  # relative to player

func _physics_process(delta):
	if Input.is_action_just_pressed("inventory"):
		for child in h_box_container.get_children():
			child.queue_free()
		for i in range(GlobalScript.player_artifacts.size()):
			var btn = Button.new()
			btn.text = "button " + str(i+i)
			h_box_container.add_child(btn)
		inventory.visible = true
	
	var input_vector = Vector2.ZERO
	
	# Only read input if not in knockback
	if not is_knockedback:
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
		input_vector = input_vector.normalized() * GlobalScript.speed
	
	# Combine with knockback
	velocity = input_vector + knockback_velocity
	move_and_slide()
	
	# Decay knockback over time
	if knockback_velocity.length() > 0:
		var decay = knockback_decay * delta
		if knockback_velocity.length() <= decay:
			knockback_velocity = Vector2.ZERO
			is_knockedback = false  # recovery complete, input restored
		else:
			knockback_velocity -= knockback_velocity.normalized() * decay
			
	update_animation()
func _process(delta: float) -> void:
	if GlobalScript.weapon_swing and !isWeaponInUse:
		print("weapong swing", weapon_timer.time_left)
		
	else:
		weapon_timer.start()
		print("no weapong swing", weapon_timer.time_left)
	weapon_instance.look_at(get_global_mouse_position())
	update_ui()

func update_ui():
	print(weapon_timer.time_left)
	health_bar.value = GlobalScript.health
	cooldown_bar.value = weapon_timer.time_left
		
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
			pass

	else:

		if velocity.x > 0:
			player_sprite.play("walking_right")
			pass
		else:
			player_sprite.play("walking_left")
			pass

func take_damage(amount, source_position, knockback_decay, strenght_amount):
	GlobalScript.health -= amount
	damage_effect()
	print("Health:", GlobalScript.health)
	check_status()
	
	var direction = (global_position - source_position).normalized()
	var strength = strenght_amount # pixels per second for knockback
	knockback_velocity = direction * strength
	
	is_knockedback = true 


func damage_effect():
	player_sprite.modulate = Color(255, 0, 0)
	color_timer.start()

func _on_color_timer_timeout() -> void:
	player_sprite.modulate = Color(1, 1, 1,1)
	
func check_status():
	if GlobalScript.health <= 0:
		gui.visible = false
		death_screen.visible = true

func show_info_screen():
	info_screen.visible = true

func _on_button_2_pressed() -> void:
	GlobalScript.health = health
	GlobalScript.speed = speed
	get_tree().change_scene_to_file("res://stages/main_area.tscn")
	


func _on_button_pressed() -> void:
	for child in h_box_container.get_children():
		child.queue_free()
	inventory.visible = false


func _on_button_1_pressed() -> void:
	info_screen.visible = false
