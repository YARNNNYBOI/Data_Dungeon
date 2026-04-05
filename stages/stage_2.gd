extends Node2D
@onready var tile_map: TileMap = $TileMap
@onready var chest: Area2D = $Chest


@onready var barriers = [$Barriers1, $Barriers2, $Barriers3, $Barriers4, $Barriers5]
@onready var barrier_location = []
@onready var room1_enem = get_tree().get_nodes_in_group("1")
@onready var room2_enem = get_tree().get_nodes_in_group("2")
@onready var room3_enem = get_tree().get_nodes_in_group("3")

@onready var last_barrier = $Barriers6

@onready var room1clear = false
@onready var room2clear = false
@onready var room3clear = false

func _ready() -> void:
	for barrier in barriers:
		barrier_location.append(barrier.global_position)
		
	for i in room3_enem:
		i.set_process(false)
		i.visible = false
		i.chasing = false
	for i in room2_enem:
		i.set_process(false)
		i.visible = false
		i.chasing = false
	for i in room1_enem:
		i.set_process(false)
		i.visible = false
		i.chasing = false
	remove_barriers()
	tile_map.z_index = -3

func  _process(delta: float) -> void:
		room1_enem = room1_enem.filter(func(n):
			return is_instance_valid(n)
		)
		if room1_enem.size() == 0 and !room1clear:
			print("Clear")
			room1clear = true
			remove_barriers()
			

		room2_enem = room2_enem.filter(func(n):
			return is_instance_valid(n)
		)
		if room2_enem.size() == 0 and !room2clear:
			print("Clear")
			room2clear = true
			remove_barriers()

		room3_enem = room3_enem.filter(func(n):
			return is_instance_valid(n)
		)
		if room3_enem.size() == 0 and !room3clear:
			print("Clear")
			room3clear = true
			remove_barriers()
			chest.show_chest()
			

func check_entered(body):
	if body.is_in_group("players"):  # optional filter
		return true
	else:
		return false
		
func remove_barriers():
	for barrier in barriers:
		barrier.global_position = Vector2(0,0)
		
func remove_last_barrier():
	last_barrier.queue_free()
	
func place_barriers():
	for i in range(barriers.size()):
		barriers[i].global_position = barrier_location[i]
		
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/main_area.tscn")


func _on_room_1_body_entered(body: Node2D) -> void:
		if check_entered(body) and room1_enem.size() > 0:
			for i in room1_enem:
				i.set_process(true)
				i.visible = true
				i.chasing = true
				place_barriers()

func _on_room_2_body_entered(body: Node2D) -> void:
		if check_entered(body) and room2_enem.size() > 0:
			for i in room2_enem:
				i.set_process(true)
				i.visible = true
				i.chasing = true
				place_barriers()

func _on_room_3_body_entered(body: Node2D) -> void:
		if check_entered(body) and room3_enem.size() > 0:
			for i in room3_enem:
				i.set_process(true)
				i.visible = true
				i.chasing = true
				place_barriers()
