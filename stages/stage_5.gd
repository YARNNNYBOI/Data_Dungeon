extends Node2D
@onready var tile_map: TileMap = $TileMap
@onready var chest: Area2D = $Chest
@onready var chest_2: Area2D = $Chest2


@onready var barriers = [$Barriers1, 
						$Barriers2, 
						$Barriers3, 
						$Barriers4, 
						$Barriers5, 
						$Barriers6, 
						$Barriers7,
						$Barriers8,
						$Barriers9,
						$Barriers10, 
						$Barriers11, 
						$Barriers12, 
						$Barriers13, 
						$Barriers14, 
						$Barriers15,
						$Barriers16]
@onready var barrier_location = []
@onready var room1_enem = get_tree().get_nodes_in_group("1")
@onready var room2_enem = get_tree().get_nodes_in_group("2")
@onready var room3_enem = get_tree().get_nodes_in_group("3")
@onready var room4_enem = get_tree().get_nodes_in_group("4")
@onready var room5_enem = get_tree().get_nodes_in_group("5")
@onready var room6_enem = get_tree().get_nodes_in_group("6")
@onready var room7_enem = get_tree().get_nodes_in_group("7")


@onready var last_barrier = $Barriers17

@onready var room1clear = false
@onready var room2clear = false
@onready var room3clear = false
@onready var room4clear = false
@onready var room5clear = false
@onready var room6clear = false
@onready var room7clear = false


@onready var collected_artifact = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for barrier in barriers:
		barrier_location.append(barrier.global_position)
		
		
	for i in room7_enem:
		i.set_process(false)
		i.visible = false
		i.chasing = false
	for i in room6_enem:
		i.set_process(false)
		i.visible = false
		i.chasing = false
	for i in room5_enem:
		i.set_process(false)
		i.visible = false
		i.chasing = false
	for i in room4_enem:
		i.set_process(false)
		i.visible = false
		i.chasing = false
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



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
			
		room4_enem = room4_enem.filter(func(n):
			return is_instance_valid(n)
		)
		if room4_enem.size() == 0 and !room4clear:
			print("Clear")
			room4clear = true
			remove_barriers()

		room5_enem = room5_enem.filter(func(n):
			return is_instance_valid(n)
		)
		if room5_enem.size() == 0 and !room5clear:
			print("Clear")
			room5clear = true
			remove_barriers()
			
		room6_enem = room6_enem.filter(func(n):
			return is_instance_valid(n)
		)
		if room6_enem.size() == 0 and !room6clear:
			print("Clear")
			room6clear = true
			remove_barriers()
			
		room7_enem = room7_enem.filter(func(n):
			return is_instance_valid(n)
		)
		if room7_enem.size() == 0 and !room7clear:
			print("Clear")
			room7clear = true
			remove_barriers()
			chest_2.show_chest()

func check_entered(body):
	if body.is_in_group("players"):  # optional filter
		return true
	else:
		return false
		
func remove_barriers():
	for barrier in barriers:
		barrier.global_position = Vector2(-600,-150)
		
func remove_last_barrier():
	last_barrier.queue_free()

func check_artifact_status():
	print("artifacts collected: ", collected_artifact)
	if collected_artifact == 2:
		remove_last_barrier()
		
func place_barriers():
	for i in range(barriers.size()):
		barriers[i].global_position = barrier_location[i]



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/main_area.tscn")


func _on_room_1_body_entered(body: Node2D) -> void:
		if check_entered(body) and room1_enem.size() > 0:
			for i in room1_enem:
				i.play_spawn_effect()
				place_barriers()


func _on_room_2_body_entered(body: Node2D) -> void:
		if check_entered(body) and room2_enem.size() > 0:
			for i in room2_enem:
				i.play_spawn_effect()
				place_barriers()

func _on_room_3_body_entered(body: Node2D) -> void:
		if check_entered(body) and room3_enem.size() > 0:
			for i in room3_enem:
				i.play_spawn_effect()
				place_barriers()

func _on_room_4_body_entered(body: Node2D) -> void:
		if check_entered(body) and room4_enem.size() > 0:
			for i in room4_enem:
				i.play_spawn_effect()
				place_barriers()


func _on_room_5_body_entered(body: Node2D) -> void:
		if check_entered(body) and room5_enem.size() > 0:
			for i in room5_enem:
				i.play_spawn_effect()
				place_barriers()


func _on_room_6_body_entered(body: Node2D) -> void:
		if check_entered(body) and room6_enem.size() > 0:
			for i in room6_enem:
				i.play_spawn_effect()
				place_barriers()


func _on_room_7_body_entered(body: Node2D) -> void:
		if check_entered(body) and room7_enem.size() > 0:
			for i in room7_enem:
				i.play_spawn_effect()
				place_barriers()
