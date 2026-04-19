extends Node2D

@onready var tile_map: TileMap = $TileMap

@onready var open_final_room = 0
func _ready() -> void:
	tile_map.z_index = -3
	remove_barrier()

func remove_final_barrier():
		print("removed")
		
func remove_barrier():
	var barrier_open = GlobalScript.player_artifacts.size()
	if barrier_open == 0 :
		$Barriers1.queue_free()
	else:
		var current_barrier = get_node("Barriers" + str(barrier_open))
		current_barrier.queue_free()




func _on_gate_1_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() == 0 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_1.tscn")

func _on_gate_2_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 2 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_2.tscn")

func _on_gate_3_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 4 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_3.tscn")

func _on_gate_4_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 6 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_4.tscn")

func _on_gate_5_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 8 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_5.tscn")

func _on_gate_6_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 10 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_6.tscn")

func _on_gate_7_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 12 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_7.tscn")

func _on_gate_8_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 14 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_8.tscn")

func _on_gate_9_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 16 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_9.tscn")
		
func _on_gate_10_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() <= 18 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_10.tscn")
