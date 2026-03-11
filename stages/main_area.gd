extends Node2D

@onready var tile_map: TileMap = $TileMap
@onready var barriers = [$Barriers, $Barriers2, $Barriers3, $Barriers4, $Barriers5, $Barriers6]
func _ready() -> void:
	print(GlobalScript.player_artifacts)
	tile_map.z_index = -3
	remove_barrier()
	
func remove_barrier():
	for barrier in range(GlobalScript.player_artifacts.size() + 1):
		barriers[barrier].queue_free()
		
	


func _on_gate_1_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() == 0 and body.is_in_group("players"):
		print("going ina")
		get_tree().change_scene_to_file("res://stages/stage_1.tscn")

func _on_gate_2_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() == 1 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_2.tscn")

func _on_gate_3_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() == 2 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_3.tscn")

func _on_gate_4_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() == 3 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_4.tscn")

func _on_gate_5_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() == 4 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_4.tscn")

func _on_gate_6_body_entered(body: Node2D) -> void:
	if GlobalScript.player_artifacts.size() == 5 and body.is_in_group("players"):
		get_tree().change_scene_to_file("res://stages/stage_5.tscn")
