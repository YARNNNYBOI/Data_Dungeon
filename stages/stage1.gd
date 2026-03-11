extends Node2D
@onready var player: CharacterBody2D = $player
@onready var barriers: StaticBody2D = $Barriers
@onready var barriers_2: StaticBody2D = $Barriers2
@onready var timer: Timer = $Timer
@onready var tile_map: TileMap = $TileMap

@onready var enemy: CharacterBody2D = $enemy
@onready var enemy_2: CharacterBody2D = $enemy2

@onready var enemy_3: CharacterBody2D = $enemy_bow
@onready var enemy_4: CharacterBody2D = $enemy_bow2


func _ready() -> void:
	tile_map.z_index = -2
	enemy.visible = false
	enemy_2.visible = false
	enemy_3.visible = false
	enemy_4.visible = false
	enemy.set_process(false)
	enemy_2.set_process(false)
	enemy_3.set_process(false)
	enemy_4.set_process(false)
	
func _process(delta: float) -> void:
	if GlobalScript.room1enemies == 2 and !GlobalScript.isRoomOnClear:
		GlobalScript.isRoomOnClear = true
		remove_barriers_room1()


func remove_barriers_room1():
	barriers_2.global_position = Vector2(0, 0)
	barriers.global_position = Vector2(0, 0)

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "player":
		print('player entered room 1')
		barriers.global_position = Vector2(683.0, -25.0)
		barriers_2.global_position = Vector2(680.0, -281.0)
		if enemy:
			enemy.chasing = true
			enemy.visible = true
			enemy.set_process(true)
		if enemy_2:
			enemy_2.chasing = true
			enemy_2.visible = true
			enemy_2.set_process(true)
			
func _on_area_2d_2_body_entered(body: Node2D) -> void:
	print(body)
	if body.name == "player":
		print('player entered room 1')
		barriers.global_position = Vector2(683.0, -25.0)
		barriers_2.global_position = Vector2(680.0, -281.0)
		if enemy_3:
			enemy_3.chasing = true
			enemy_3.visible = true
			enemy_3.set_process(true)
		if enemy_4:
			enemy_4.chasing = true
			enemy_4.visible = true
			enemy_4.set_process(true)
