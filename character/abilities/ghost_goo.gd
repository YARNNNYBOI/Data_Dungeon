extends Area2D
@onready var disapear_timer: Timer = $disapear_timer
@onready var windup: Timer = $windup
@onready var player : CharacterBody2D

@onready var isWindupStart = false

@onready var enemy_meta 
@onready var enemy_parent 
@export var enemy_type : String
@export var damage_amount : int


@export var knockback_decay = 1
@export var strenght_amount = 1

var direction: Vector2 = Vector2.ZERO
var speed: float = 200
var target_position: Vector2 = Vector2.ZERO
var reached_target := false

func _ready() -> void:
	disapear_timer.start()
	

func _process(delta):
	print(windup.time_left)
	if reached_target:
		return

	if target_position == null:
		return

	position += direction * speed * delta

	if position.distance_to(target_position) < 5:
		reached_target = true
		direction = Vector2.ZERO

func _on_disapear_timer_timeout() -> void:
	self.queue_free()

func damage():
	print("attack")
	var enemy = player
	if enemy.has_method("take_damage"):
		enemy.take_damage(damage_amount, self.global_position, knockback_decay, strenght_amount)
		print("success")
	else:
		print("no hitbox found")
	isWindupStart = false



func _on_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	
	if parent == enemy_parent:
		#print("player left")
		windup.stop()
		isWindupStart = false


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		if !isWindupStart:
			player = body
			print("player found")
			isWindupStart = true
			windup.start()


func setup(start_pos: Vector2, target: Vector2):
	global_position = start_pos
	target_position = target
	direction = (target - start_pos).normalized()

func _on_windup_timeout() -> void:
	damage()

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		print("player left")
		isWindupStart = false
		windup.stop()
