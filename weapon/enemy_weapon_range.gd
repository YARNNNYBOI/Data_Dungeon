extends Node2D
@onready var timer: Timer = $Timer


@onready var projectile_scene = preload("res://weapon/projectile.tscn")
@onready var weaponready = true
@onready var damage_amount = 5

@export var enemy_type : String

@onready var player: CharacterBody2D = null

func _ready():
	var players = get_tree().get_nodes_in_group("players")
	if players.size() > 0:
		player = players[0]
		
func shoot():
	var projectile = projectile_scene.instantiate()
	
	# Set position first
	projectile.global_position = global_position

	# Set direction toward player
	if player:
		projectile.direction = (player.global_position - global_position).normalized()
		projectile.rotation = projectile.direction.angle()

	projectile.damage = damage_amount
	projectile.enemy_type = "player"

	get_tree().current_scene.add_child(projectile)
	
func _process(delta: float) -> void:
	if player:
		look_at(player.global_position)
