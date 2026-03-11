extends Node2D

@onready var windup: Timer = $windup

@onready var enemy_meta 
@onready var enemy_parent 

@export var winduptime = 0.2
@export var enemy_type : String
@export var damage_amount = 10
var isWindupStart = false

@export var knockback_decay = 500
@export var strenght_amount = 200
func _ready() -> void:
	windup.wait_time = winduptime
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	var parent = area.get_parent()
	var meta = parent.get_meta("character")
	enemy_meta = meta
	enemy_parent = parent
	if parent.name == enemy_type and !isWindupStart:
		print("player found")
		isWindupStart = true
		windup.start()

func damage(meta):
	print("attack")
	var enemy = enemy_parent
	if enemy.has_method("take_damage") and meta == enemy_type:
		enemy.take_damage(damage_amount, self.global_position, knockback_decay, strenght_amount)
		print("success")
	else:
		print("no hitbox found")
	isWindupStart = false


func _on_area_2d_area_exited(area: Area2D) -> void:
	var parent = area.get_parent()
	
	if parent == enemy_parent:
		#print("player left")
		windup.stop()
		isWindupStart = false

func _on_windup_timeout() -> void:
	damage(enemy_meta)
